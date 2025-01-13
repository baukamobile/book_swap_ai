import 'package:book_swap_ai/components/bottomnavbar.dart';
import 'package:book_swap_ai/main.dart';
import 'package:book_swap_ai/pages/auth/login_page.dart';
import 'package:book_swap_ai/pages/auth/register_page.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Book {
  final String title;
  final String author;
  final String description;
  final String condition;
  final String imageUrl;
  final String owner;

  Book({
    required this.title,
    required this.author,
    required this.description,
    required this.condition,
    required this.imageUrl,
    required this.owner,
  });


  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        title: json['title'],
        author: json['author'],
        description: json['description'],
        condition: json['condition'],
        imageUrl: json['image'],
        // Image URL returned by API
        owner: json['owner']['name']);
  }
}
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
  
  String name = '';  // Переменная для имени
  String email = '';  // Переменная для email

  @override
  void initState() {
    super.initState();
    fetchBooks();
    getUserName();  // Здесь ты вызываешь getUserName для получения данных пользователя
  }

  // Функция для получения данных пользователя
  Future<void> getUserName() async {
    try {
      final response = await http.get(Uri.parse(
        'https://testbackendflutter-0471b16deb32.herokuapp.com/api/users/24/'
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
          'https://testbackendflutter-0471b16deb32.herokuapp.com/api/books/18/'));

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
