import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:livemusic/api/database_api.dart';
import 'package:livemusic/colors.dart';
import 'package:livemusic/view/cardview.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  FirebaseAuth auth = FirebaseAuth.instance;
  List<Bookmark> bookmarks = [];
  List<Favorite> favorites = [];

  //Futures loading
  Future<List<Bookmark>> bookmarksFuture;
  Future<List<Favorite>> favoriteFuture;

  @override
  void initState() {
    bookmarksFuture = _getBookmarks();
    favoriteFuture = _getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'Welcome back',
          style: TextStyle(color: primaryWhiteColor),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: FutureBuilder(
                future: favoriteFuture,
                builder: (context, AsyncSnapshot<List<Favorite>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      return _listFavorites(snapshot);
                      break;
                    default:
                      return Text('');
                  }
                },
              ),
            ),
            Container(
              child: FutureBuilder(
                future: bookmarksFuture,
                builder: (context, AsyncSnapshot<List<Bookmark>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      return _listBookmarks(snapshot);
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

  Widget _listFavorites(AsyncSnapshot<List<Favorite>> snapshot) {
    return snapshot.data.isNotEmpty
        ? Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Favorite artists',
                    style: TextStyle(fontSize: 18, color: primaryColor),
                  ),
                ),
              ),
              Container(
                color: secondaryBackgroundColor,
                margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                height: 180,
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return snapshot.data[index].isFavorite
                        ? CardView(snapshot.data[index].imageUrl,
                            snapshot.data[index].artistName,
                            artistId: snapshot.data[index].artistId)
                        : null;
                  },
                  itemCount: snapshot.data.length,
                ),
              ),
            ],
          )
        : Text('');
  }

  Widget _listBookmarks(AsyncSnapshot<List<Bookmark>> snapshot) {
    return snapshot.data.isNotEmpty
        ? Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Saved concerts',
                    style: TextStyle(fontSize: 18, color: primaryColor),
                  ),
                ),
              ),
              Container(
                color: secondaryBackgroundColor,
                margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                height: 180,
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return snapshot.data[index].isBookmarked
                        ? CardView(snapshot.data[index].imageUrl,
                            snapshot.data[index].artistName,
                            artistId: snapshot.data[index].bookmarkId)
                        : null;
                  },
                  itemCount: snapshot.data.length,
                ),
              ),
            ],
          )
        : Text('');
  }

  Future<List<Bookmark>> _getBookmarks() async {
    DatabaseAPI databaseAPI = DatabaseAPI.instance;
    bookmarks = await databaseAPI.getBookmarks();
    /*print('databaseAPI:');
    bookmarks.forEach((element) {
      print(element.bookmarkId);
      print(element.isBookmarked);
      print(element.timestamp);
      print(element.artistName);
    });*/
    return bookmarks;
  }

  Future<List<Favorite>> _getFavorites() async {
    DatabaseAPI databaseAPI = DatabaseAPI.instance;
    favorites = await databaseAPI.getFavorites();
    return favorites;
  }
}
