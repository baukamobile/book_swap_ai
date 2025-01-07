import 'dart:convert';
<<<<<<< HEAD
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

=======
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:book_swap_ai/pages/chatting.dart';
import 'package:http/http.dart' as http;

class Book {
  final String title;
  final String author;
  final String description;
  final String condition;
  final String imageUrl;

>>>>>>> e99f00d (search page error with size books)
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

<<<<<<< HEAD
<<<<<<< HEAD
List<String> sorts = <String>['low to high', 'high to low', 'New In'];
List<String> cities = <String>['Astana', 'Almaty', 'Shymkent', 'Aktobe', 'Karagandy'];
List<Book> books = [];
String dropdownValue = genres.first;
String dropdownValue2 = sorts.first;
String dropdownValue3 = cities.first;
=======
List<String> genres = ['Fiction', 'Mystery', 'Fantasy', 'Sci-Fi', 'Romance'];
=======
List<String> genres = ['Fiction', 'Mystery', 'Fantasy', 'Sci-Fi', 'Romance', 'Horror', 'Thriller', 'Biography', 'History', 'Self-Help'];
>>>>>>> 98d77da (list genres updated and padding. i should update size of app)
List<String> sorts = ['low to high', 'high to low', 'New In'];
List<String> cities = ['Astana', 'Almaty', 'Shymkent', 'Aktobe', 'Karagandy'];
>>>>>>> e99f00d (search page error with size books)

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
=======

>>>>>>> 0f87910 (size of search pages books changed well)
  String dropdownValue = genres.first;
  String dropdownValue2 = sorts.first;
  String dropdownValue3 = cities.first;
  List<Book> books = [];

  Future<void> fetchBooks() async {
    try {
      final response = await http.get(Uri.parse(
          'https://testbackendflutter-0471b16deb32.herokuapp.com/api/books/'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<Book> allBooks = data.map((json) => Book.fromJson(json)).toList();

        // Randomly select between 3 to 7 books without repetition
        int randomCount = Random().nextInt(5) + 11;
        allBooks.shuffle();
        setState(() {
          books = allBooks.take(randomCount).toList();
        });
      } else {
        throw Exception('Failed to load books: ${response.statusCode}');
>>>>>>> e99f00d (search page error with size books)
      }
    } catch (e) {
      print('Error: $e');
    }
  }

<<<<<<< HEAD
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
=======
  @override
  void initState() {
    super.initState();
    fetchBooks();
>>>>>>> e99f00d (search page error with size books)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      body: Padding(
<<<<<<< HEAD
        padding: const EdgeInsets.all(8.0),
=======
        padding: const EdgeInsets.all(16.0),
>>>>>>> e99f00d (search page error with size books)
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
                    // Add search functionality here
                  },
                ),
              ],
            ),
<<<<<<< HEAD
            const SizedBox(height: 15),

            // Filter Row (Sorting, Location, Genre, AI Chat)
=======
            const SizedBox(height: 20),
>>>>>>> e99f00d (search page error with size books)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDropdown(
                  value: dropdownValue2,
                  icon: Icons.sort,
                  items: sorts,
                  onChanged: (value) => setState(() {
                    dropdownValue2 = value!;
                  }),
                ),
                _buildDropdown(
                  value: dropdownValue3,
                  icon: Icons.location_on,
                  items: cities,
                  onChanged: (value) => setState(() {
                    dropdownValue3 = value!;
                  }),
                ),
                _buildDropdown(
                  value: dropdownValue,
                  icon: Icons.arrow_downward,
                  items: genres,
                  onChanged: (value) => setState(() {
                    dropdownValue = value!;
                  }),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GeminiChat()),
                  ),
                  child: Image.asset('assets/img/ai.jpg', width: 40),
                ),
<<<<<<< HEAD
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
=======
              ],
            ),
            // const SizedBox(height: 20),
            books.isEmpty
                ? const Center(child: Text("No books available"))
                : Expanded(
                    child: GridView.builder(
  padding: const EdgeInsets.all(10),
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2, // Number of columns
    crossAxisSpacing: 10, // Horizontal spacing between items
    mainAxisSpacing: 10, // Vertical spacing between items
  ),
  itemCount: books.length,
  itemBuilder: (BuildContext context, int index) {
                        final book = books[index];
                        return Container(
                          width: 100,
                          height: 250,

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              // margin: EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.network(book.imageUrl,width: 105,),
                                    Text(book.title),
                                    Text(
                                  '${book.author}\nCondition: ${book.condition}'),
                                    
                                  ],
=======
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
                    }),
                  ),
                  _buildDropdown(
                    value: dropdownValue3,
                    icon: Icons.location_on,
                    items: cities,
                    onChanged: (value) => setState(() {
                      dropdownValue3 = value!;
                    }),
                  ),
                  _buildDropdown(
                    value: dropdownValue,
                    icon: Icons.arrow_downward,
                    items: genres,
                    onChanged: (value) => setState(() {
                      dropdownValue = value!;
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
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 10, // Horizontal spacing between items
            mainAxisSpacing: 10, // Vertical spacing between items
          ),
          itemCount: books.length,
          itemBuilder: (BuildContext context, int index) {
                          final book = books[index];
                          return Container(
<<<<<<< HEAD
                            width: 100,
                            height: 250,
        
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                // margin: EdgeInsets.all(10),
<<<<<<< HEAD
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Image.network(book.imageUrl,width: 105,),
                                      Text(book.title),
                                      Text(
                                    '${book.author}\nCondition: ${book.condition}'),
                                      
                                    ],
                                  ),
>>>>>>> 98d77da (list genres updated and padding. i should update size of app)
=======
                                child: Column(
                                  children: [
                                    Image.network(book.imageUrl,),
                                    Text(book.title),
                                    Text(
                                  '${book.author}\nCondition: ${book.condition}'),
                                  ],
>>>>>>> 775912f (search page book image size changed but still not correctly)
                                ),
                              ),
                            ),
                          );
=======
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
                        Text(
                          'Condition: ${book.condition}',
                          style: const TextStyle(color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )]));
>>>>>>> 0f87910 (size of search pages books changed well)
                        },
                      ),
                    ),
<<<<<<< HEAD
                  ),
>>>>>>> e99f00d (search page error with size books)
          ],
=======
            ],
          ),
>>>>>>> 98d77da (list genres updated and padding. i should update size of app)
        ),
      ),
    );
  }
<<<<<<< HEAD
=======

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
<<<<<<< HEAD
>>>>>>> e99f00d (search page error with size books)
}
=======
}
>>>>>>> 0f87910 (size of search pages books changed well)
