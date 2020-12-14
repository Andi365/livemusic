import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:livemusic/model/colors.dart';
import 'package:livemusic/controller/notifier/saved_artists_notifier.dart';
import 'package:livemusic/controller/notifier/saved_bookmarks_notifier.dart';
import 'package:livemusic/view/cardview.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  SavedArtistsNotifer savedArtists;
  SavedBookmarksNotifer savedBookmarks;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    savedArtists = Provider.of<SavedArtistsNotifer>(context);
    savedBookmarks = Provider.of<SavedBookmarksNotifer>(context);
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(child: _listFavorites()),
              Container(child: _listBookmarks()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listFavorites() {
    return savedArtists.savedArtists.isNotEmpty
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
                    return savedArtists.savedArtists[index].isFavorite
                        ? CardView(savedArtists.savedArtists[index].imageUrl,
                            savedArtists.savedArtists[index].artistName,
                            artistId: savedArtists.savedArtists[index].artistId)
                        : null;
                  },
                  itemCount: savedArtists.savedArtists.length,
                ),
              ),
            ],
          )
        : Text('');
  }

  Widget _listBookmarks() {
    return savedBookmarks.savedBookmarks.isNotEmpty
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
                    return CardView(
                      savedBookmarks.savedBookmarks[index].imageUrl,
                      savedBookmarks.savedBookmarks[index].venueName,
                      venueId: savedBookmarks.savedBookmarks[index].venueId,
                      concertId:
                          savedBookmarks.savedBookmarks[index].bookmarkId,
                    );
                  },
                  itemCount: savedBookmarks.savedBookmarks.length,
                ),
              ),
            ],
          )
        : Text('');
  }
}
