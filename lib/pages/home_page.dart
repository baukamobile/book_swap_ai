import 'dart:convert';
import 'dart:math'; // Import for random selection
import 'package:book_swap_ai/components/user_chat.dart';
import 'package:book_swap_ai/pages/profile.dart' as ProfilePage;
import 'package:book_swap_ai/themes/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:book_swap_ai/consts.dart';
import 'package:book_swap_ai/components/models/book_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // List<Book> books = [];
  List<Book> books = [];
  
  final CardSwiperController _controller = CardSwiperController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  void initState() {
    super.initState();
    fetchBooks();
  }
  

  Future<void> fetchBooks() async {
    try {
      final response = await http.get(Uri.parse(
          '$server/app/api/books/'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<Book> allBooks = data.map((json) => Book.fromJson(json)).toList();

        // Randomly select between 3 to 7 books without repetition
        int randomCount = Random().nextInt(10) + 3;
        allBooks.shuffle();
        setState(() {
          // books = allBooks.take(randomCount).toList();
          books = allBooks;
        });
      } else {
        throw Exception('Failed to load books: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Books',style: TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),

        // appBar: AppBar(
        //   backgroundColor: Colors.amber,
        //   title: const Text('Books'),
        // ),
        body: books.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
              children: [
                Expanded(
                  child: CardSwiper(
                    controller: _controller,
                    cardsCount: books.length,
                    cardBuilder: (context, index, _, __) {
                      final book = books[index];
                      return Card(
                        
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Stack(children: [
                                  Image.network(
                                    book.imageUrl,
                                    fit: BoxFit.contain,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.error),
                                  ),

                                ]),
                              ),
                            ),
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      book.title,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => UserChat(ownerName: book.owner,)), 
                                              );
                                            
                                          },
                                          child: Image(
                                            image: AssetImage(
                                                'assets/img/chat.png'),
                                            width: 10,
                                          ),
                                        ),
                                        Text("${book.owner}"),
                                      ],
                                    ),
                                  ],
                                ),
                                Text('Author: ${book.author}'),
                                Text('Condition: ${book.condition}'),
                                Text('Price: ${book.price}'),
                                Text(
                                  book.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        backgroundColor: Colors.amber[400],
                        onPressed: _controller.undo,
                        child: const Icon(
                          Icons.rotate_left,
                          color: Colors.white,
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