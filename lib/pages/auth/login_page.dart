import 'package:book_swap_ai/pages/auth/register_page.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void register(context){
    Navigator.pop(
      context,
       MaterialPageRoute(builder:(context)=>RegisterPage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Login',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 33
              ),),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Email",
                  enabledBorder: OutlineInputBorder(
                    

                  ),
                  focusedBorder: OutlineInputBorder(

                  ),
                ),
                
              ),
            ),

          ),
          const SizedBox(height: 20,),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Password",
                  enabledBorder: OutlineInputBorder(

                  ),
                  focusedBorder: OutlineInputBorder(

                  ),
                ),
                
              ),
            ),

          ), Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: 200,
                  color: Colors.green,
                  child: TextButton(onPressed: (){}, child: Text("Log In", style: TextStyle(
                        color: Colors.white,
                      ))),
                    
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont't have an account? "),
                      TextButton(onPressed: (){
                        register(context);
                      }, child: Text("Register", style: TextStyle(
                        color: Colors.green,
                      ),))
                    ],
                  )
              ],
            ),
            ),




        ],
      ),
    );
  }
}