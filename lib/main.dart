import 'package:book_swap_ai/components/bottomnavbar.dart';
import 'package:book_swap_ai/pages/chatting.dart';
import 'package:flutter/material.dart';
import 'package:book_swap_ai/pages/auth/login_page.dart';
import 'package:book_swap_ai/pages/auth/register_page.dart';
import 'package:book_swap_ai/pages/chat_page.dart';
import 'package:book_swap_ai/pages/home_page.dart';
import 'package:book_swap_ai/pages/profile.dart';
import 'consts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
void main() 
async {
  // await dotenv.load(); // Load .env file
  Gemini.init(
  apiKey: GEMINI_API_KEY,
  );
  // initializeGemini(); 
  // Gemini.init(apiKey: dotenv.env['GEMINI_API_KEY']!);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      // theme: ThemeData(
        
      //     // scaffoldBackgroundColor: scaffoldBackgroundColor,
      //     appBarTheme: AppBarTheme(
      //       // color: cardColor,
      //     )),
      // home: HomePage(),
      // const GeminiChat(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text('BookSwapAI')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        // child: _screens[_selectedIndex], // Display the current selected screen
      ),
           //   ],
      // ),
    bottomNavigationBar: Bottomnavbar(),
    );
  }
}

