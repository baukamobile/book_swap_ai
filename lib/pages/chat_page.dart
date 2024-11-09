import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Chat'),
      //   backgroundColor: Colors.deepPurple, // Example color
      // ),
      body: ListView(
        padding: const EdgeInsets.all(10.0), // Padding for the whole ListView
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
              IconButton(
                icon: const Icon(Icons.search, size: 50,),
                onPressed: () {
                  // Add your search functionality here
                },
              ),
            ],
          ),
          const SizedBox(height: 20), // Space between the rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Something",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                // height: 200,
                // width: 200,
                // padding: const EdgeInsets.all(8.0),
                // decoration: BoxDecoration(
                //   color: Colors.deepPurple.shade100, // Example background color
                //   borderRadius: BorderRadius.circular(10.0),
                // ),
                child: Image.asset('assets/img/ai.jpg'),
)

            ],
          ),
        ],
      ),
    );
  }
}
