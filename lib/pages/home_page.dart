import 'dart:convert';
import 'package:flutter/material.dart';
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
      imageUrl: json['image'],  // This is the image URL returned by the API
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
  try {
    final response = await http.get(Uri.parse('http://192.168.0.102:8000/api/books/3'));
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        books = data.map((bookData) => Book.fromJson(bookData)).toList();
      });
    } else {
      throw Exception('Failed to load books: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    // Optionally show a dialog or message to the user if there is a problem
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('nothing'),
      
      centerTitle: true,),
      body: books.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(book.imageUrl),  // Display book image from the URL
                    title: Text(book.title),
                    subtitle: Text('${book.author}\nCondition: ${book.condition}'),
                  ),
                );
              },
            ),
    );
  }
}
