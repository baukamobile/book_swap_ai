import 'package:book_swap_ai/main.dart';
import 'package:book_swap_ai/pages/auth/register_page.dart';
import 'package:book_swap_ai/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidden = true;
  // Controllers for the text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Function to handle login
  Future<void> loginUser() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      // Show error if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill in both fields'),
        backgroundColor: Colors.red,
      ));
      return;
    }
    final Map<String, String> loginData = {
      'email': email,
      'password': password,
    };
    final response = await http.post(
      Uri.parse('https://peaceful-refuge-96948-e42c6be7d8b8.herokuapp.com/api/login/'),  // Replace with your Django API login URL
      headers: {'Content-Type': 'application/json'},
      body: json.encode(loginData),
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login successful'),
        backgroundColor: Colors.green,
      ));
      Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => HomePage()),
  (Route<dynamic> route) => false,
);

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login failed'),
        backgroundColor: Colors.red,
      ));
    }
  }

  void register(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()), // Navigate to RegisterPage
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  icon: Icon(Icons.close),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Login',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 33),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      
                      controller: passwordController,
                      obscureText: hidden, // To hide the password
                      decoration: InputDecoration(

                        hintText: "Password",

                        border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(20.0),
              ),

              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidden = !hidden; // Меняем состояние
                  });
                },
                icon: Icon(hidden
                    ? Icons.visibility_off
                    : Icons.visibility), // Меняем иконку
              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: 200,
                          
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green,
                          ),
                          child: TextButton(
                            onPressed: loginUser,
                            child: Text(
                              "Log In",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account? "),
                            TextButton(
                              onPressed: () {
                                register(context);
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
