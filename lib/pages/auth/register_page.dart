import 'package:book_swap_ai/pages/auth/login_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void login(context){
    Navigator.push(
      context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Register',style: TextStyle(
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
                    hintText: "Name",
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
        
            ),
             const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 50,
                  width: 200,
                  color: Colors.green,
                    child: TextButton(onPressed: (){}, child: Text("Register", style: TextStyle(
                        color: Colors.white,
                      ))),
                      
                      
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? "),
                        TextButton(onPressed: (){
                          login(context);
                        }, child: Text("Log in", style: TextStyle(
                          color: Colors.green,
                        ),))
                      ],
                    )
                ],
              ),
              ),
        
        
        
        
          ],
        ),
      ),
    );
  }
}