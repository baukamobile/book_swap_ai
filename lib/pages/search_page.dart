import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<String> genres = [
  'Fiction', 'Mystery', 'Fantasy', 'Sci-Fi', 'Romance', 'Thriller', 'Horror', 'Dystopian', 'Classics', 'Biography', 'Memoirs', 'Self-Help', 'Non-Fiction', 'Adventure', 'Poetry'
];

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
      imageUrl: json['image'],
    );
  }
}

List<String> sorts = <String>['low to high', 'high to low', 'New In'];
List<String> cities = <String>['Astana', 'Almaty', 'Shymkent', 'Aktobe', 'Karagandy'];
List<Book> books = [];
String dropdownValue = genres.first;
String dropdownValue2 = sorts.first;
String dropdownValue3 = cities.first;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      final response = await http.get(Uri.parse('https://testbackendflutter-0471b16deb32.herokuapp.com/api/books/'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          books = data.map((book) => Book.fromJson(book)).toList();
        });
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Build Dropdown for Genre, Sort, and Location
  Widget _buildDropdown({
    required String value,
    required IconData icon,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      width: 100,
      child: DropdownButton<String>(
        value: value,
        icon: Icon(icon),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  // AI Chat Button
  Widget _buildAiChatButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.chat),
      onPressed: () {
        // Implement AI Chat functionality here
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    // Add search functionality here
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),

            // Filter Row (Sorting, Location, Genre, AI Chat)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDropdown(
                  value: dropdownValue2,
                  icon: Icons.sort,
                  items: sorts,
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue2 = value!;
                    });
                  },
                ),
                _buildDropdown(
                  value: dropdownValue3,
                  icon: Icons.location_on,
                  items: cities,
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue3 = value!;
                    });
                  },
                ),
                _buildDropdown(
                  value: dropdownValue,
                  icon: Icons.arrow_downward,
                  items: genres,
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                ),
                _buildAiChatButton(context),
              ],
            ),
            const SizedBox(height: 15),

            // GridView for displaying books
            Expanded(
              child: books.isNotEmpty
                  ? GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                child: Image.network(
                                  book.imageUrl,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 50),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.title,
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text('Author: ${book.author}', maxLines: 1, overflow: TextOverflow.ellipsis),
                                    Text('Condition: ${book.condition}'),
                                    Text(
                                      book.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
