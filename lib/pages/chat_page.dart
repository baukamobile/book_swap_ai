import 'package:book_swap_ai/components/chat_with_them.dart';
import 'package:book_swap_ai/components/models/chat_screen.dart';
import 'package:book_swap_ai/pages/chatting.dart';
import 'package:book_swap_ai/pages/gemini_chat.dart';
import 'package:flutter/material.dart';
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: 
        ListView(
          padding: const EdgeInsets.symmetric(vertical: 9,horizontal:14 ), // Padding for the whole ListView
          children: [
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Space between TextField and Icon
                  Container(
                    width: 50,
                    height: 50,
                    child: InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>GeminiChatPage())),
                      child: Image.asset('assets/img/ai.jpg',width: 30,)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Space between the rows
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children:[
                   GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatScreen()));
                    },
                     child: ChatWithThem(
                      name: "Sam",
                      lastname: "Smith", 
                      message: "Это полезно, например, для создания ",
                      book: "Crime And Punishment",
                      ),
                   ),
                    SizedBox(height: 10,),
                     ChatWithThem(
                    name: "Sam",
                    lastname: "Smith", 
                    message: "Это полезно, например, для создания ",
                    book: "Crime And Punishment",
                    ),
                    SizedBox(height: 10,),
                     ChatWithThem(
                    name: "Sam",
                    lastname: "Smith", 
                    message: "Это полезно, например, для создания ",
                    book: "Crime And Punishment",
                    ),
                    SizedBox(height: 10,),
                ]
              ),
            ),
          ],
        ),
      
      ),
    );
  }
}
