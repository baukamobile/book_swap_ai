import 'package:book_swap_ai/pages/home_page.dart';
import 'package:flutter/material.dart';



class UserChat extends StatefulWidget {
  UserChat({super.key, required this.ownerName});
  final String ownerName;

  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ownerName), // Use widget.ownerName here
        leading: IconButton(
          onPressed: () {
  Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end, // Aligns the input bar at the bottom
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
