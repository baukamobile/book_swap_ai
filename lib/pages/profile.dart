import 'package:book_swap_ai/pages/auth/register_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  void register(context){
    Navigator.push(
      context,
       MaterialPageRoute(builder:(context)=>RegisterPage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: (){
                        register(context);
                      }, child: Text("Register", style: TextStyle(
                        color: Colors.green,
                      ),)),
      ),
    );
  }
}