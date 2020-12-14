import 'package:flutter/material.dart';
import 'package:livemusic/model/colors.dart';
import 'package:livemusic/notifier/navigation_notifier.dart';
import 'package:livemusic/view/feed.dart';
import 'package:livemusic/view/home.dart';
import 'package:livemusic/view/profilePage.dart';
import 'package:provider/provider.dart';

class Navigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Navigation();
}

class _Navigation extends State<Navigation> {
  var currentTab = [
    Home(),
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
          print('index is: $index');
        },
        selectedItemColor: secondaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: secondaryBackgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: secondaryBackgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Concerts',
            backgroundColor: secondaryBackgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.portrait),
            label: 'Profile',
            backgroundColor: secondaryBackgroundColor,
          ),
        ],
      ),
    );
  }
}
