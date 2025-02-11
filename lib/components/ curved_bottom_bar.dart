

import 'package:book_swap_ai/pages/add_book.dart';
import 'package:book_swap_ai/pages/chat_page.dart';
import 'package:book_swap_ai/pages/home_page.dart';
import 'package:book_swap_ai/pages/profile.dart';
import 'package:book_swap_ai/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() => runApp(MaterialApp(home: CurvedBottomNavBar()));

class CurvedBottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<CurvedBottomNavBar> {
    final List<Widget> _screens = [
    const HomePage(),
    const SearchPage(),
    const AddBook(),
    const ChatPage(),
    const ProfilePage(),
  ];
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          items: <Widget>[
            Icon(Icons.home, size: 25,weight: 30),
            Icon(Icons.search, size: 25,weight: 30),
            Icon(Icons.add, size: 25,weight: 30),
            Icon(Icons.chat, size: 25,weight: 30),
            Icon(Icons.account_circle, size: 25,weight: 30),
          ],
          color: const Color.fromARGB(255, 247, 245, 244),
          buttonBackgroundColor: const Color.fromARGB(255, 251, 250, 249),
          backgroundColor: Colors.green,
          animationCurve: Curves.easeOutQuint,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: IndexedStack(
          index: _page,
          children: _screens,
        )
        //  Container(
        //   color: Colors.blueAccent,
        //   child: Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: <Widget>[
        //         Text(_page.toString(), style: TextStyle(fontSize: 160)),
        //         ElevatedButton(
        //           child: Text('Go To Page of index 1'),
        //           onPressed: () {
        //             final CurvedNavigationBarState? navBarState =
        //                 _bottomNavigationKey.currentState;
        //             navBarState?.setPage(1);
        //           },
        //         )
        //       ],
        //     ),
        //   ),
        // )
        
        );
  }
}




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
//     const AddBook(),
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
