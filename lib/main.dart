import 'package:book_swap_ai/components/%20curved_bottom_bar.dart';
import 'package:book_swap_ai/components/bottomnavbar.dart';
import 'package:book_swap_ai/pages/add_book.dart';
import 'package:book_swap_ai/pages/chatting.dart';
import 'package:book_swap_ai/themes/dark_mode.dart';
import 'package:book_swap_ai/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:book_swap_ai/pages/auth/login_page.dart';
import 'package:book_swap_ai/pages/auth/register_page.dart';
import 'package:book_swap_ai/pages/chat_page.dart';
import 'package:book_swap_ai/pages/profile.dart';
import 'consts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'dart:convert';
import 'dart:math'; // Import for random selection
import 'package:book_swap_ai/components/user_chat.dart';
import 'package:book_swap_ai/pages/profile.dart' as ProfilePage;
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:http/http.dart' as http;
import 'components/models/book_model.dart';
void main() 
async {
  Gemini.init(
  apiKey: GEMINI_API_KEY,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: HomePage(),
      // const GeminiChat(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        body: books.isEmpty
            ? Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: const Center(child: CircularProgressIndicator()),
            )
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
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.error),
                                  ),
                                ]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
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
                                              width: 40,
                                            ),
                                          ),
                                          Text("${book.owner}")
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text('Author: ${book.author}'),
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
            bottomNavigationBar: CurvedBottomNavBar(),
      ),
      
    );
  }
}

