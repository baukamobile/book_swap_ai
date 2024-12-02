import 'package:book_swap_ai/pages/auth/login_page.dart';
import 'package:book_swap_ai/pages/auth/register_page.dart';
import 'package:book_swap_ai/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Book {
  final String title;
  final String author;
  final String description;
  final String condition;
  final String imageUrl;

  Book({
    required this.title,
    required this.author,
    required this.description,
    required this.condition,
    required this.imageUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      author: json['author'],
      description: json['description'],
      condition: json['condition'],
      imageUrl: json['image'], // Image URL returned by API
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

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      final response = await http.get(Uri.parse('https://testbackendflutter-0471b16deb32.herokuapp.com/api/books/4/'));

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

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

  String name = "Tom";
  String email = "tom@gmail.com";
  var phoneNumber = 77775456787;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child:Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust horizontal alignment
  crossAxisAlignment: CrossAxisAlignment.center, // Adjust vertical alignment
  children: [
    IconButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
      },
      icon: Icon(Icons.bookmark),
    ),
    IconButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
      },
      icon: Icon(Icons.exit_to_app),
    ),
  ],
),
              ),
                
              //    Align(
              //     alignment: Alignment.topRight,
              //     child: IconButton(
              //       onPressed: () {
              //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
              //       },
              //       icon: Icon(Icons.exit_to_app),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 20),
              //   child: Align(
              //     alignment: Alignment.topLeft,
              //     child: IconButton(
              //       onPressed: () {
              //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
              //       },
              //       icon: Icon(Icons.bookmark),
              //     ),
              //   ),
              // ),
          
          
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: AssetImage('assets/img/avtr.jpg'),
                  ),
                  const SizedBox(height: 20),
                  _buildProfileDetailRow("Name:", name),
                  _buildProfileDetailRow("Email:", email),
                  _buildProfileDetailRow("Phone Number:", phoneNumber.toString()),
                  const SizedBox(height: 20),
                  Container(
                    child: Text("Active Books"),
                  ),
                  const SizedBox(height: 10),
                  books.isNotEmpty
                      ? SizedBox(
                          height: 200, // Adjust height as needed
                          child: ListView.builder(
                            itemCount: books.length,
                            itemBuilder: (context, index) {
                              final book = books[index];
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
                                },
                                child: Card(
                                  child: ListTile(
                                    leading: Image.network(book.imageUrl),
                                    title: Text(book.title),
                                    subtitle: Text('${book.author}\nCondition: ${book.condition}'),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
