import 'package:flutter/material.dart';

class Book {
  final String title;
  final String author;
  final String description;
  final String condition;
  final String imageUrl;
  final double price;
  final DateTime created_at;
  final String region;
  final String genre;
  final String owner;

  Book({
    required this.title,
    required this.author,
    required this.description,
    required this.condition,
    required this.imageUrl,
    required this.price,
    required this.created_at,
    required this.region,
    required this.genre,
    required this.owner,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      author: json['author'],
      description: json['description'],
      condition: json['condition'],
      imageUrl: json['image'],
      // price: json['price'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      created_at: DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now(),
      region: json['region'],
      genre: json['genre'],
      owner: json['owner']['name']

    );
  }
}


// class BookModel extends StatelessWidget {
//   const BookModel({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//     );
//   }
// }