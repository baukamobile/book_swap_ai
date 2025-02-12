import 'package:book_swap_ai/main.dart';
import 'package:book_swap_ai/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:book_swap_ai/consts.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool hidden = true;
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> register() async {
  String email = _emailController.text.trim();
  String name = _nameController.text.trim();
  String password = _passwordController.text.trim();

  if (email.isEmpty || name.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('All fields are required')),
    );
    return;
  }

  try {
    final response = await http.post(
      Uri.parse('$server/app/api/register/'),
      body: json.encode({
        'email': email,
        'name': name,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201 || response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      final error = json.decode(response.body)['error'] ?? 'Unknown error';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: $error')),
      );
    }
  } catch (e) {
    print('Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to connect to server')),
    );
  }
}
//copied from 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 17),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
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
                      'Register',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 33),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _emailController,
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
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "Name",
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
                      controller: _passwordController,
                      obscureText: hidden,
                      decoration: InputDecoration(
                        hintText: "Password",
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
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: register,
                            child: Text(
                              "Register",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account? "),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginPage()),
                                );
                              },
                              child: Text(
                                "Log in",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
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


//temp branch