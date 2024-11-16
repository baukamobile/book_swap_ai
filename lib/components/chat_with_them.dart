import 'package:flutter/material.dart';


class ChatWithThem extends StatelessWidget {
  ChatWithThem({super.key
  , required this.name, required this.lastname, required this.message
  });
  String name = 'Tom';
  String lastname = 'Jerry';
  String message = 'Let me know if you have additional';
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/img/avatar.jpg'),height: 90,),
            Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: 5,),
            Column(
              children: [
                
                Text("$message", style: TextStyle(
                      color: Colors.black, 
                    ),),
        
              ],
            )
          ],
        ),

    );
  }
}