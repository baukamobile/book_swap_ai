import 'package:book_swap_ai/pages/add_book.dart';
import 'package:book_swap_ai/pages/chat_page.dart';
import 'package:book_swap_ai/pages/home_page.dart';
import 'package:book_swap_ai/pages/profile.dart';
import 'package:book_swap_ai/pages/search_page.dart';
import 'package:flutter/material.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int _selectedIndex = 0;

  // List of screens for BottomNavigationBar
  final List<Widget> _screens = [
    const HomePage(),
    const SearchPage(),
    const AddBook(),
    const ChatPage(),
    const ProfilePage(),
  ];

  // Update the selected index when a new BottomNavigationBar item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Display the selected screen in the body
      body: _screens[_selectedIndex],
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Keep track of the selected index
        onTap: _onItemTapped, // Update the screen when an item is tapped
        items: const <BottomNavigationBarItem>[
          
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF00FFFF),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF1FF5E4D),

            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF32CD32),
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF967BB6),
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFFFFDF00),
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
