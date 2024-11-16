import 'package:flutter/material.dart';


class ChatWithThem extends StatelessWidget {
  ChatWithThem({super.key
  // , required this.name, required this.lastname
  });
  String name = 'Tom';
  String lastname = 'Jerry';
  String _message = 'Let me know if you have additional requirements, like adding borders or shadows!';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image(image: AssetImage('assets/img/avatar.jpg')),
            Column(
              children: [
                Row(
                  children: [
                    Text("$name", style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold
                    ),),
                    SizedBox(width: 5,),
                    Text("$lastname", style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold
                    ),),
                    
                  ],
                ),
                Text("$_message", style: TextStyle(
                      color: Colors.black, 
                    ),),
        
              ],
            )
          ],
        ),
      ),
    );
  }
}