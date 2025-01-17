import 'dart:io';
import 'dart:typed_data';

import 'package:book_swap_ai/components/models/services.dart';

import 'package:book_swap_ai/consts.dart';
import 'package:book_swap_ai/widgets/chat_widget.dart';
import 'package:book_swap_ai/widgets/text_widget.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

class GeminiChat extends StatefulWidget {
  const GeminiChat({super.key});

  @override
  State<GeminiChat> createState() => _GeminiChatState();
}

class _GeminiChatState extends State<GeminiChat> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(id: "1", firstName: "Gemini");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("AI Chat"),
        backgroundColor: Colors.blueAccent,
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
      inputOptions: InputOptions(
        trailing: [
          IconButton(onPressed: (){
            _sendMediaMessage();

          }, icon: Icon(Icons.image))
        ]
      ),
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages]; // Insert user's message
    });

    try {
      String question = chatMessage.text;
      List<Uint8List>? images;
      if(chatMessage.medias?.isNotEmpty ?? false){
        images = [
          File(chatMessage.medias!.first.url).readAsBytesSync(),
          ];
      }
      gemini.streamGenerateContent(question, images: images).listen(
        (event) {
          ChatMessage? lastMessage = messages.firstOrNull;
          // Only add response if it's from Gemini and it's not the last message
          if (lastMessage!=null &&lastMessage.user==gemini) {
            // && messages.isNotEmpty && messages.first.user == geminiUser
            // return; // Don't repeat last response
            lastMessage = messages.removeAt(0);
            String response = event.content?.parts?.fold("", (previous, current) => "$previous ${current.text}") ?? "";
            lastMessage.text += response;
            setState(() {
              messages = [lastMessage!,...messages];
            });
          }

          String response = event.content?.parts?.fold("", (previous, current) => "$previous ${current.text}") ?? "";
          ChatMessage geminiResponse = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );

          setState(() {
            messages = [geminiResponse, ...messages]; // Insert Gemini's response
          });
        },
        onError: (error) {
          print("Error during Gemini stream: $error");
        },
      );
    } catch (e) {
      print("Error sending message: $e");
    }
  }
  void _sendMediaMessage() async{
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file!=null){
      ChatMessage chatMessage = ChatMessage(
        user: currentUser, 
        createdAt: DateTime.now(),
       text: "Describe this picture!",
        medias: [
          ChatMedia(url: file.path, 
          fileName: "",
           type: MediaType.image)]);
           _sendMessage(chatMessage);

    }
  }
}
