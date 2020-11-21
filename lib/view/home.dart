import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:livemusic/colors.dart';
import 'package:livemusic/view/cardview.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'Welcome back ${auth.currentUser.displayName}',
          style: TextStyle(color: primaryWhiteColor),
        ),
      ),
      body: SafeArea(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Upcoming',
                      style: TextStyle(fontSize: 18, color: primaryColor),
                    ),
                  ),
                ),
                Container(
                  color: secondaryBackgroundColor,
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                  height: 200,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 150,
                        child: CardView(
                            "https://firebasestorage.googleapis.com/v0/b/live-music-app-b45e2.appspot.com/o/Bands%2Farctic_mokeys.jpg?alt=media&token=7f6a764d-80b5-416e-a383-663f2aee3012",
                            "INSERT",
                            2),
                      );
                    },
                    itemCount: 3,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
