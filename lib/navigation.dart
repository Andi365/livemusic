import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Color.fromRGBO(242, 153, 74, 1),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
          backgroundColor: Color.fromRGBO(48, 44, 45, 1),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Search'),
          backgroundColor: Color.fromRGBO(48, 44, 45, 1),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.music_note),
          title: Text('Concerts'),
          backgroundColor: Color.fromRGBO(48, 44, 45, 1),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.portrait),
          title: Text('Profile'),
          backgroundColor: Color.fromRGBO(48, 44, 45, 1),
        )
      ],
    );
  }
}
