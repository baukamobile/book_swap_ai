import 'package:book_swap_ai/pages/chat_page.dart';
import 'package:book_swap_ai/pages/home_page.dart';
import 'package:book_swap_ai/pages/profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'BookSwapAI',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF6A0DAD),

        // backgroundColor: Color(0xFF4B0082),
        // textTheme: TextTheme(
        //   TextStyle(color: Color(0xFFE0E0E0)),
        // ),
      ),
      home: const MyHomePage(),
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

  // Список экранов для BottomNavigationBar
  final List<Widget> _screens = [
    const HomePage(),
    const ChatPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Обновляем выбранный индекс
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('BookSwapAI')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: _screens[_selectedIndex],
      ), // Отображаем текущий экран
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Обработчик изменения выбранного элемента
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Экран для главной страницы
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Home Screen', style: Theme.of(context).textTheme.bodyMedium),
//     );
//   }
// }

// Экран чата с OpenAI
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Chat with AI', style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}

// Экран профиля пользователя
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Screen', style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}
