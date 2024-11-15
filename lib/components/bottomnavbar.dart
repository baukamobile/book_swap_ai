import 'package:book_swap_ai/pages/chat_page.dart';
import 'package:book_swap_ai/pages/home_page.dart';
import 'package:book_swap_ai/pages/profile.dart';
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
      
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex, // Keep track of the selected index
          onTap: _onItemTapped, // Update the screen when an item is tapped
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
      ),
    );
  }
}
