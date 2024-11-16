import 'package:flutter/material.dart';


class ChatWithThem extends StatelessWidget {
  ChatWithThem({super.key, required this.name});
  String name = 'Tom';
  String lastname = 'Jerry';
  String _message = 'Let me know if you have additional requirements, like adding borders or shadows!';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Image(image: AssetImage('assets/img/avatar.jpg')),
          Column(
            children: [

            ],
          )
        ],
      ),
    );
  }
}