import 'dart:convert';
import 'dart:math';
import 'package:book_swap_ai/themes/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:book_swap_ai/pages/chatting.dart';
import 'package:http/http.dart' as http;

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
      region: json['region'] ?? '',
      genre: json['genre'] ?? '',

    );
  }
}

List<String> genres = ['Fiction', 'Mystery', 'Fantasy', 'Sci-Fi', 'Romance', 'Horror', 'Thriller', 'Biography', 'History', 'Self-Help'];
List<String> sorts = ['low to high', 'high to low', 'New In'];
List<String> cities = ['Astana', 'Almaty', 'Shymkent', 'Aktobe', 'Karagandy'];

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String dropdownValue = genres.first;
  String dropdownValue2 = sorts.first;
  String dropdownValue3 = cities.first;
  List<Book> books = [];
  void sortBooksByPrice() {
  setState(() {
    if (dropdownValue2 == 'low to high') {
      books.sort((a, b) => a.price.compareTo(b.price)); 
    } else if (dropdownValue2 == 'high to low') {
      books.sort((a, b) => b.price.compareTo(a.price)); 
    } else if (dropdownValue2 == 'New In') {
      books.sort((a, b) => b.created_at.compareTo(a.created_at));
    }
  });
}
void sortBooksByRegion() {
  setState(() {
    books = books.where((book) => book.region == dropdownValue3 || book.region.isEmpty).toList();
  });
}
void sortBooksByGenre(){
  setState(() {
    books = books.where((book) => book.genre == dropdownValue || book.genre.isEmpty).toList();
  });
}

  Future<void> fetchBooks() async {
    try {
      final response = await http.get(Uri.parse(
          'https://peaceful-refuge-96948-e42c6be7d8b8.herokuapp.com/app/api/books/'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<Book> allBooks = data.map((json) => Book.fromJson(json)).toList();
        // Randomly select between 3 to 7 books without repetition
        int randomCount = allBooks.length;
        allBooks.shuffle();
        setState(() {
          books = allBooks.take(randomCount).toList();
        });
      } else {
        throw Exception('Failed to load books: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  @override
  void initState() {
    super.initState();
    fetchBooks();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.search, size: 30),
                    onPressed: () {
                      // Add your search functionality here
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDropdown(
                  value: dropdownValue2,
                  icon: Icons.sort,
                  items: sorts,
                  onChanged: (value) => setState(() {
                    dropdownValue2 = value!;
                    setState(() {
                      // books = allBooks.take(randomCount).toList();
                      sortBooksByPrice();  // <-- После загрузки сортируем
                      });}),

                  ),
                  _buildDropdown(
                    value: dropdownValue3,
                    icon: Icons.location_on,
                    items: cities,
                    onChanged: (value) => setState(() {
                      dropdownValue3 = value!;
                      sortBooksByRegion();
                    }),
                  ),
                  _buildDropdown(
                    value: dropdownValue,
                    icon: Icons.arrow_downward,
                    items: genres,
                    onChanged: (value) => setState(() {
                      dropdownValue = value!;
                      sortBooksByGenre();
                    }),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GeminiChat()),
                    ),
                    child: Image.asset('assets/img/ai.jpg', width: 40),
                  ),
                ],
              ),
              // const SizedBox(height: 20),
              books.isEmpty
                  ? const Center(child: Text("No books available"))
                  : Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(5),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, 
                      crossAxisSpacing: 10, 
                      mainAxisSpacing: 10, 
          ),
          itemCount: books.length,
          itemBuilder: (BuildContext context, int index) {
                          final book = books[index];
                          return Container(
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.network(
                        book.imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 50),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        // Text('Price: ${book.price}'),
                        Text(
                          // 'Condition: ${book.condition}',
                          'Price: ${book.price}',
                          style: const TextStyle(color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )]));
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildDropdown({
    required String value,
    required IconData icon,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButton<String>(
      value: value,
      icon: Icon(icon),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}