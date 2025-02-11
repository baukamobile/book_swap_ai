import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiChat extends StatefulWidget {
  const GeminiChat({super.key});

  @override
  State<GeminiChat> createState() => _GeminiChatState();
}
class Message {
  final String content;
  final String sender;

  Message({required this.content, required this.sender});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'],
      sender: json['sender'],
    );
  }
}

class _GeminiChatState extends State<GeminiChat> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(id: "1", firstName: "Gemini");

  @override
  void initState() {
    super.initState();
    _loadMessages();  // Загрузка сообщений при старте
  }

  Future<void> _loadMessages() async {
    try {
      final response = await http.get(Uri.parse('https://peaceful-refuge-96948-e42c6be7d8b8.herokuapp.com/chat/messages/messages.json'));
    
      if (response.statusCode == 200) {
        List<dynamic> jsonMessages = json.decode(response.body);
        setState(() {
          messages = jsonMessages.map((msg) => ChatMessage.fromJson(msg)).toList();
        });
      } else {
        print("Failed to load messages: ${response.statusCode}");
      }
    } catch (e) {
      print("Error loading messages: $e");
    }
  }
  
  Future<void> _saveMessages() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/messages.json');
      String jsonMessages = json.encode(messages.map((msg) => msg.toJson()).toList());
      await file.writeAsString(jsonMessages);
    } catch (e) {
      print("Error saving messages: $e");
    }
  }

  @override
  void dispose() {
    _saveMessages();  
    super.dispose();
  }
  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];  // Insert user's message
    });

    _saveMessages();

    try {
      String question = chatMessage.text;
      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [
          File(chatMessage.medias!.first.url).readAsBytesSync(),
        ];
      }
      gemini.streamGenerateContent(question, images: images).listen(
        (event) {
          ChatMessage? lastMessage = messages.firstOrNull;
          if (lastMessage != null && lastMessage.user == gemini) {
            lastMessage = messages.removeAt(0);
            String response = event.content?.parts?.fold("", (previous, current) => "$previous ${current.text}") ?? "";
            lastMessage.text += response;
            setState(() {
              messages = [lastMessage!, ...messages];
            });
          }

          String response = event.content?.parts?.fold("", (previous, current) => "$previous ${current.text}") ?? "";
          ChatMessage geminiResponse = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );

          setState(() {
            messages = [geminiResponse, ...messages];  // Insert Gemini's response
          });

          // Сохраняем обновленные сообщения после получения ответа
          _saveMessages();
        },
        onError: (error) {
          print("Error during Gemini stream: $error");
        },
      );
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  // Отправка медиа сообщения
  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text: "Describe this picture!",
        medias: [
          ChatMedia(
            url: file.path,
            fileName: "",
            type: MediaType.image,
          )
        ],
      );
      _sendMessage(chatMessage);
    }
  }

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
          }, icon: Icon(Icons.image)),
        ]
      ),
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }
}
