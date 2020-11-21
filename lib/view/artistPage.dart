import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:livemusic/api/concert_api.dart';
import 'package:livemusic/api/database_api.dart';
import 'package:livemusic/colors.dart';
import 'package:livemusic/model/Venue.dart';
import 'package:livemusic/notifier/artist_notifier.dart';
import 'package:livemusic/notifier/concert_notifier.dart';
import 'package:livemusic/view/concertsView.dart';
import 'package:livemusic/view/sliverTopBar.dart';
import 'package:provider/provider.dart';

import 'bio.dart';
import 'members.dart';
import 'rating.dart';

class ArtistPage extends StatefulWidget {
  final int index;

  @override
  State<StatefulWidget> createState() {
    return _ArtistPage();
  }

  ArtistPage(this.index);
}

class _ArtistPage extends State<ArtistPage> {
  bool _isLiked = false;
  DatabaseAPI database = DatabaseAPI.instance;

  void _isLikedCheck(ArtistNotifier artistNotifier) async {
    Favorite f = await database.getFavorite(artistNotifier.currentArtist.id);
    if (f == null) {
      print('no entry found');
    }
    print('Found entry: ${f.toMap().toString()}');
    print(f.isFavorite);
    if (f.isFavorite) {
      setState(() {
        _isLiked = false;
      });
      f.isFavorite = false;
      await database.update(f);
    } else {
      setState(() {
        _isLiked = true;
      });
      f.isFavorite = true;
      await database.update(f);
    }
  }

  void _check(ArtistNotifier artistNotifier) async {
    Favorite f = await database.getFavorite(artistNotifier.currentArtist.id);
    if (f == null) {
      f = Favorite();
      f.artistId = artistNotifier.currentArtist.id;
      f.isFavorite = false;
      _isLiked = false;
      print('No entry found, inserted new');
      database.insert(f);
    } else {
      if (f.isFavorite) {
        _isLiked = true;
      } else {
        _isLiked = false;
      }
    }
  }

  @override
  void initState() {
    ArtistNotifier artistNotifier =
        Provider.of<ArtistNotifier>(context, listen: false);
    _check(artistNotifier);

    ConcertNotifier concertNotifier =
        Provider.of<ConcertNotifier>(context, listen: false);

    getConcerts(artistNotifier.currentArtist.id, concertNotifier);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    ConcertNotifier concertNotifier =
        Provider.of<ConcertNotifier>(context, listen: false);

    getVenuesConcertView(concertNotifier);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ArtistNotifier artistNotifier = Provider.of<ArtistNotifier>(context);
    ConcertNotifier concertNotifier = Provider.of<ConcertNotifier>(context);
    var _desc = artistNotifier.currentArtist.bio;
    var _rating = artistNotifier.currentArtist.rating;
    var _ratingCount = artistNotifier.currentArtist.noOfRatings;
    int _index = widget.index;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverTopBar(
                    index: _index,
                    artistNotifier: artistNotifier,
                    isLiked: _isLiked,
                    isLikedCheck: _isLikedCheck),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Rating(_rating, _ratingCount),
                      _genre(),
                    ],
                  ),
                )
              ];
            },
            body: Column(
              children: [
                TabBar(
                  indicatorColor: primaryColor,
                  labelColor: primaryColor,
                  unselectedLabelColor: primaryWhiteColor,
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  tabs: [
                    Tab(text: 'General information'),
                    Tab(text: 'Concerts'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Bio(_desc),
                            Members(),
                          ],
                        ),
                      ),
                      ConcertsView(concertNotifier: concertNotifier),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _genre() {
    return Row(
      children: [
        Icon(
          Icons.music_video,
          color: primaryColor,
        ),
        Padding(
          padding: EdgeInsets.only(left: 8),
          child:
              Text('Rock', style: TextStyle(fontSize: 18, color: primaryColor)),
        ),
      ],
    );
  }
}
