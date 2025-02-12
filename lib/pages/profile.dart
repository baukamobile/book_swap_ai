import 'package:book_swap_ai/components/bottomnavbar.dart';
import 'package:book_swap_ai/main.dart';
import 'package:book_swap_ai/pages/auth/login_page.dart';
import 'package:book_swap_ai/pages/auth/register_page.dart';
import 'package:book_swap_ai/components/models/book_model.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:book_swap_ai/consts.dart';


class User{
  final String name;
  final String email;
  
  User({
    required this.name,
    required this.email,
  });
  factory User.fromJson(Map<String, dynamic> json){
    return User(
      name: json['name'],
      email: json['email'],
      );
  }
}
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  List<Book> books = [];
  List<User> user = [];
  
  String name = '';  
  String email = ''; 

  @override
  void initState() {
    super.initState();
    fetchBooks();
    getUserName();  
  }


  Future<void> getUserName() async {
    try {
      final response = await http.get(Uri.parse(
        '$server/app/api/users/24/'
      ));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        setState(() {
          name = data['name'];  // Сохраняем имя
          email = data['email'];  // Сохраняем email
        });
      } else {
        throw Exception('Error with network');
      }
    } catch (e) {
      print('Error: $e');
      print('username is $name');
      print('useremail is $email');
    }
  }

  Future<void> fetchBooks() async {
    try {
      final response = await http.get(Uri.parse(
          '$server/app/api/books/13/'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          books = [Book.fromJson(data)];
        });
      } else {
        throw Exception('Failed to load book: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      icon: Icon(Icons.bookmark),
                    ),
                    Text(
                      "Profile Page",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginPage()));
                      },
                      icon: Icon(Icons.exit_to_app),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: AssetImage('assets/img/avtr.jpg'),
                  ),
                  const SizedBox(height: 20),
                  _buildProfileDetailRow("Name:", name),  // Используем name
                  _buildProfileDetailRow("Email:", email),  // Используем email
                  const SizedBox(height: 20),
                  Container(
                    child: Text("Active Books"),
                  ),
                  const SizedBox(height: 10),
                  books.isNotEmpty
                      ? SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: books.length,
                            itemBuilder: (context, index) {
                              final book = books[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                },
                                child: Card(
                                  child: ListTile(
                                    leading: Image.network(book.imageUrl),
                                    title: Text(book.title),
                                    subtitle: Text(
                                        '${book.author}\nCondition: ${book.condition} \n Owner: ${book.owner}'),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const Center(child: Text('No books.')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text('$label '),
            Text(value),
          ],
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
      ],
    );
  }
}
