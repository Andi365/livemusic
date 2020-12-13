import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:livemusic/api/database_api.dart';
import 'package:livemusic/notifier/artist_notifier.dart';
import 'package:livemusic/notifier/concert_notifier.dart';
import 'package:livemusic/notifier/savedBookmarks_notifier.dart';
import 'package:provider/provider.dart';

import '../colors.dart';

class ConcertsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConcertsView();
  }

  ConcertsView();
}

class _ConcertsView extends State<ConcertsView> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseAPI database = DatabaseAPI.instance;
  ConcertNotifier concertNotifier;
  ArtistNotifier artistNotifier;
  SavedBookmarksNotifer savedBookmarks;

  void _checkForBookmarks(
      ConcertNotifier concertNotifier, ArtistNotifier artistNotifier) async {
    for (int i = 0; i < concertNotifier.upcomingConcerts.length; i++) {
      Bookmark bookmark = await database
          .getBookmark(concertNotifier.upcomingConcerts[i].concertId);
      if (bookmark == null) {
        bookmark = Bookmark(
            concertNotifier.upcomingConcerts[i].concertId,
            concertNotifier.upcomingConcerts[i].venueName,
            artistNotifier.currentArtist.image,
            concertNotifier.upcomingConcerts[i].venueId);
        database.insertBookmark(bookmark);
        print('No entry found, inserted new ${bookmark.toMap().toString()}');
      }
    }
  }

  void _isBookmarked(Bookmark bookmark) async {
    if (bookmark == null) {
      print('invalid bookmark');
    }
    if (bookmark.isBookmarked) {
      savedBookmarks.remove();
      setState(() {
        bookmark.isBookmarked = false;
      });
      await database.updateBookmark(bookmark);
      print(
          'Bookmark with id: ${bookmark.bookmarkId} updated to: ${bookmark.isBookmarked}');
    } else {
      setState(() {
        bookmark.isBookmarked = true;
      });
      await database.updateBookmark(bookmark);
      savedBookmarks.add(bookmark);
      print(
          'Bookmark with id: ${bookmark.bookmarkId} updated to: ${bookmark.isBookmarked}');
    }
  }

  @override
  void initState() {
    concertNotifier = Provider.of<ConcertNotifier>(context, listen: false);
    artistNotifier = Provider.of<ArtistNotifier>(context, listen: false);
    savedBookmarks = Provider.of<SavedBookmarksNotifer>(context, listen: false);
    _checkForBookmarks(concertNotifier, artistNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    concertNotifier = Provider.of<ConcertNotifier>(context);
    artistNotifier = Provider.of<ArtistNotifier>(context);
    TabController _tabController;

    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [];
        },
        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              indicatorColor: primaryColor,
              labelColor: primaryColor,
              unselectedLabelColor: primaryWhiteColor,
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              tabs: [
                Tab(text: 'Upcoming'),
                Tab(text: 'Previous'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: concertNotifier.upcomingConcerts.isNotEmpty
                        ? _concertList(true)
                        : _noConcert(),
                  ),
                  SingleChildScrollView(
                    child: concertNotifier.previousConcerts.isNotEmpty
                        ? _concertList(false)
                        : _noConcert(),
                  )
                ],
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _concertList(bool upcomingOrPrevious) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) => Divider(
        height: 2,
        color: primaryColor,
        indent: 10,
        endIndent: 10,
      ),
      itemCount: upcomingOrPrevious
          ? concertNotifier.upcomingConcerts.length
          : concertNotifier.previousConcerts.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        upcomingOrPrevious
                            ? concertNotifier.upcomingConcerts[index].venueName
                            : concertNotifier.previousConcerts[index].venueName,
                        style: TextStyle(color: primaryColor, fontSize: 18),
                      ),
                      Text(
                        upcomingOrPrevious
                            ? _formatTime(
                                concertNotifier.upcomingConcerts[index].date)
                            : _formatTime(
                                concertNotifier.previousConcerts[index].date),
                        style: TextStyle(color: primaryWhiteColor),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: upcomingOrPrevious
                      ? FutureBuilder(
                          future: _bookmark(index),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                return snapshot.data;
                              }
                            } else {
                              CircularProgressIndicator();
                            }
                            return Text('');
                          })
                      : Text(''),
                ),
              ),
              _button(
                context,
                upcomingOrPrevious,
                index,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<Widget> _bookmark(int index) async {
    Bookmark bookmark = await database
        .getBookmark(concertNotifier.upcomingConcerts[index].concertId);
    return IconButton(
      onPressed: () {
        _isBookmarked(bookmark);
      },
      icon: bookmark.isBookmarked
          ? Icon(
              Icons.bookmark,
              color: primaryColor,
            )
          : Icon(
              Icons.bookmark_border,
              color: primaryColor,
            ),
    );
  }

  Widget _button(BuildContext context, bool upcomingOrPrevious, int index) {
    return RaisedButton(
      onPressed: () {
        concertNotifier.currentConcert = upcomingOrPrevious
            ? concertNotifier.upcomingConcerts[index]
            : concertNotifier.previousConcerts[index];
        if (auth.currentUser.isAnonymous) {
          Navigator.of(context).popAndPushNamed('/votepage');
        } else {
          Navigator.of(context).pushNamed('/votepage');
        }
      },
      color: primaryColor,
      child: Row(
        children: [
          Text(
            upcomingOrPrevious ? 'Buy ticket' : 'Rate',
            style: TextStyle(
                fontSize: 10,
                color: primaryWhiteColor,
                fontWeight: FontWeight.w600),
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
          Icon(
            upcomingOrPrevious ? Entypo.ticket : Icons.star,
            color: primaryWhiteColor,
            size: 20,
          )
        ],
      ),
    );
  }

  Widget _noConcert() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 15),
        child: Text(
          'No concerts available',
          style: TextStyle(color: primaryColor, fontSize: 20),
        ),
      ),
    );
  }

  String _formatTime(Timestamp time) {
    DateTime date = time.toDate();
    return '${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}';
  }
}
