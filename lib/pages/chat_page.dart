import 'package:book_swap_ai/components/chat_with_them.dart';
import 'package:book_swap_ai/pages/chatting.dart';
import 'package:flutter/material.dart';
// List<String> genres = <String>['fantasy', 'Fiction', 'Detective', 'Drama'];
// List<String> sorts = <String>['Price low to high','Price high to low', 'New In'];
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  
  // String dropdownValue = genres.first;
  // String dropdownValue2 = sorts.first;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Chat'),
        //   backgroundColor: Colors.deepPurple, // Example color
        // ),
        body: 
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 45), // Padding for the whole ListView
            children: [
              Row(
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
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>GeminiChat())),
                      child: Image.asset('assets/img/ai.jpg',width: 30,)),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Space between the rows
              ChatWithThem(
                // name: "Sam",lastname: "Smith"
                ),
            ],
          ),
        ),
      
      ),
    );
  }
}
