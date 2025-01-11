import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sam Smith"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0), //padding pull request testing
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
           // Aligns the input bar at the bottom
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type here",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.send, size: 30),
                  onPressed: () {
                    // Action for the send button
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
