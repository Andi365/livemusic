import 'package:flutter/material.dart';
import 'package:livemusic/notifier/navigation_notifier.dart';
import 'package:livemusic/notifier/rating_notifier.dart';
import 'package:livemusic/view/feed.dart';
import 'package:livemusic/view/profilePage.dart';
import 'package:provider/provider.dart';

class Navigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Navigation();
}

class _Navigation extends State<Navigation> {
  var currentTab = [
    Feed(),
    Feed(),
    ProfilePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    NavigationNotifer navigationProvider =
        Provider.of<NavigationNotifer>(context);
    return Scaffold(
      body: currentTab[navigationProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationProvider.currentIndex,
        onTap: (index) {
          navigationProvider.currentIndex = index;
        },
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
          ),
        ],
      ),
    );
  }
}
