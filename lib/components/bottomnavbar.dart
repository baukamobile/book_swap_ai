// import 'package:book_swap_ai/pages/add_book.dart';
// import 'package:book_swap_ai/pages/chat_page.dart';
// import 'package:book_swap_ai/pages/home_page.dart';
// import 'package:book_swap_ai/pages/profile.dart';
// import 'package:book_swap_ai/pages/search_page.dart';
// import 'package:flutter/material.dart';

// class Bottomnavbar extends StatefulWidget {
//   const Bottomnavbar({super.key});

//   @override
//   State<Bottomnavbar> createState() => _BottomnavbarState();
// }

// class _BottomnavbarState extends State<Bottomnavbar> {
//   int _selectedIndex = 0;

//   final List<Widget> _screens = [
//     const HomePage(),
//     const SearchPage(),
//     // const AddBook(),
//     const ChatPage(),
//     const ProfilePage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_selectedIndex],
      
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex, // Keep track of the selected index
//         onTap: _onItemTapped, // Update the screen when an item is tapped
//         items: const <BottomNavigationBarItem>[
          
//           BottomNavigationBarItem(
//             backgroundColor: Color.fromARGB(255, 28, 70, 70),
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Color(0xFF1FF5E4D),

//             icon: Icon(Icons.search),
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Color.fromARGB(255, 29, 87, 29),
//             icon: Icon(Icons.add),
//             label: 'Add',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Color(0xFF967BB6),
//             icon: Icon(Icons.chat),
//             label: 'Chat',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Color.fromARGB(255, 122, 112, 46),
//             icon: Icon(Icons.account_circle),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }
