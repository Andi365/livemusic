import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:livemusic/api/database_api.dart';
import 'package:livemusic/colors.dart';
import 'package:livemusic/view/cardview.dart';
import 'package:sqflite/sqflite.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future getBookmarkFuture;
  List<Bookmark> bookmarks = [];

  Future<List<Bookmark>> _query() async {
    DatabaseAPI databaseAPI = DatabaseAPI.instance;
    bookmarks = await databaseAPI.getBookmarks();
    print('databaseAPI:');
    bookmarks.forEach((element) {
      print(element.bookmarkId);
      print(element.isBookmarked);
      print(element.timestamp);
      print(element.artistName);
    });
    return bookmarks;
  }

  @override
  void initState() {
    super.initState();
  }

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
          children: [
            Container(
              child: FutureBuilder(
                future: _query(),
                builder: (context, AsyncSnapshot<List<Bookmark>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      return _listWidget(snapshot);
                      break;
                    default:
                      return Text('');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listWidget(AsyncSnapshot<List<Bookmark>> snapshot) {
    return snapshot.data.isNotEmpty
        ? Column(
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
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return snapshot.data[index].isBookmarked
                        ? CardView(snapshot.data[index].imageUrl,
                            snapshot.data[index].artistName)
                        : null;
                  },
                  itemCount: snapshot.data.length,
                ),
              )
            ],
          )
        : Text('');
  }
}
