import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:livemusic/notifier/navigation_notifier.dart';
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
      /*FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context, user) {
          if (user.connectionState == ConnectionState.waiting) {
            return Container();
          } else {
            return currentTab[navigationProvider.currentIndex];
          }
        },
      ),*/
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationProvider.currentIndex,
        onTap: (index) {
          navigationProvider.currentIndex = index;
        },
        selectedItemColor: Color.fromRGBO(242, 153, 74, 1),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromRGBO(48, 44, 45, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Color.fromRGBO(48, 44, 45, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Concerts',
            backgroundColor: Color.fromRGBO(48, 44, 45, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.portrait),
            label: 'Profile',
            backgroundColor: Color.fromRGBO(48, 44, 45, 1),
          ),
        ],
      ),
    );
  }
}
