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
// import 'package:flutter_gemini/';
// class Chatting extends StatefulWidget {
//   const Chatting({super.key});

//   @override
//   State<Chatting> createState() => _ChattingState();
// }

// class _ChattingState extends State<Chatting> {
  
//   final _openAI = OpenAI.instance.build(
//     token: OPENAI_API_KEY2,
//     baseOption: HttpSetup(
//       receiveTimeout: Duration(seconds: 10),
//     ),
//     enableLog: true,
//   );
//   final ChatUser _currentUser =
//       ChatUser(id: '1', firstName: 'noname', lastName: 'user');
//   final ChatUser _gptcurrentUser =
//       ChatUser(id: '2', firstName: 'Chat', lastName: 'gpt');
//   List<ChatMessage> _messages = <ChatMessage>[];
//   List<ChatUser> _typeUsers = <ChatUser>[];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: DashChat(
//         typingUsers: _typeUsers,
//         currentUser: _currentUser,
//         messageOptions: const MessageOptions(
//           currentUserContainerColor: Colors.amber,
//           containerColor: Colors.black,
//         ),
//         onSend: (ChatMessage m) {
//           getChatResponse(m);
//         },
//         messages: _messages,
//       ),
//     );
//   }

//  Future<void> getChatResponse(ChatMessage m) async {
//   // Insert user's message and show typing status for GPT
//   setState(() {
//     _messages.insert(0, m);
//     _typeUsers.add(_gptcurrentUser);
//   });

//   // Convert chat history into the required API format
//   List<Map<String, dynamic>> _messagesHistory = _messages.map((m) {
//     return {
//       'role': m.user == _currentUser ? 'user' : 'assistant',
//       'content': m.text,
//     };
//   }).toList();

//   final request = ChatCompleteText(
//     model: GptTurbo0301ChatModel(), // Use the string 'gpt-4' instead of Gpt4ChatModel()
//     messages: _messagesHistory,
//     maxToken: 200,
//   );

//   // Print the request before sending it to the API
//   print("API Request Messages: $_messagesHistory");

//   try {
//     // Send the API request
//     final response = await _openAI.onChatCompletion(request: request);
//     print("API Response: ${response?.choices?.first?.message?.content}");

//     if (response != null && response!.choices != null && response!.choices.isNotEmpty) {
//       for (var element in response!.choices) {
//         if (element.message != null) {
//           setState(() {
//             _messages.insert(0, ChatMessage(
//               user: _gptcurrentUser,
//               createdAt: DateTime.now(),
//               text: element.message!.content,
//             ));
//           });
//         }
//       }
//       // Remove typing status once response is received
//       setState(() {
//         _typeUsers.remove(_gptcurrentUser);
//       });
//     } else {
//       print("No valid response or choices in the API response.");
//     }
//   } catch (e) {
//     print("Error occurred: $e"); // Log the error for debugging
//   }
// }
// }


// class Chatting extends StatefulWidget {
//   const Chatting({super.key});

//   @override
//   State<Chatting> createState() => _ChattingState();
// }

// class _ChattingState extends State<Chatting> {



//   final bool _istyping = true; 
//   late TextEditingController textEditingController;

//   @override
//   void initState() {
//     textEditingController = TextEditingController();
//     super.initState();
//   }
//   @override
//   void dispose() {
//     textEditingController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
        
//         ],
//         title: Text("Chat Gpt", style: TextStyle(
//           color: Colors.white
//         ),),
//         leading: Padding(padding: EdgeInsets.all(8),
        
//         child: Image.asset(AssetsImage.userLogo),
//         ),


//       ),
//       body: SafeArea(
//         child: Column(  
//           children: [
//             Flexible(child: 

//             ListView.builder(
//               itemCount: 4,
//               itemBuilder: (context, index){
                
//               return ChatWidget(
//                 msg: ChatMessages[index]["msg"].toString(),
//                  chatIndex:int.parse(ChatMessages[index]["chatIndex"].toString()),
//                  );
//             }
//             )),
            
//             if(_istyping)...[
//               const SpinKitThreeBounce(
//                 color: Colors.white,
//                 size: 18,
//               ),
//               Material(
//                 color: cardColor,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Expanded(child: TextField(
//                         style: TextStyle(color: Colors.white),
//                         controller: textEditingController,
//                         onSubmitted: (value){
                  
//                         },
//                         decoration: InputDecoration(
//                           hintText: "Start chatting"
//                         ),
//                       ),
                      
//                       ),
//                       IconButton(onPressed: (){}, icon: Icon(Icons.send,color: Colors.white,))
//                     ],
//                   ),
//                 ),
//               )
//             ]
//           ],
//         ),
//       ),
//     );
//   }
// }



// dd

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
