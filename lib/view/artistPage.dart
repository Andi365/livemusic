import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:livemusic/api/artist_api.dart';
import 'package:livemusic/api/concert_api.dart';
import 'package:livemusic/api/database_api.dart';
import 'package:livemusic/model/colors.dart';
import 'package:livemusic/model/Artist.dart';
import 'package:livemusic/notifier/artist_notifier.dart';
import 'package:livemusic/notifier/concert_notifier.dart';
import 'package:livemusic/notifier/savedArtists_notifier.dart';
import 'package:livemusic/view/concertsView.dart';
import 'package:provider/provider.dart';

class ArtistPage extends StatefulWidget {
  final Map<String, dynamic> map;

  @override
  State<StatefulWidget> createState() {
    return _ArtistPage();
  }

  ArtistPage(this.map);
}

class _ArtistPage extends State<ArtistPage> {
  bool _isLiked = false;
  SavedArtistsNotifer savedArtist;
  DatabaseAPI database = DatabaseAPI.instance;
  Map<String, dynamic> artistMap;
  Future<Artist> _artist;
  ArtistNotifier artistNotifier;

  @override
  void initState() {
    artistMap = widget.map;
    _artist = _getArtist();

    _checkForFavorite();
    ConcertNotifier concertNotifier =
        Provider.of<ConcertNotifier>(context, listen: false);

    savedArtist = Provider.of<SavedArtistsNotifer>(context, listen: false);
    getConcerts(artistMap['artistId'], concertNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    artistNotifier = Provider.of<ArtistNotifier>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: FutureBuilder(
        future: _artist,
        builder: (context, AsyncSnapshot<Artist> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return SafeArea(
                child: DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, _) {
                      return [
                        _sliverTopBar(),
                        SliverToBoxAdapter(
                          child: Row(
                            children: [
                              _rating(snapshot.data.rating,
                                  snapshot.data.noOfRatings),
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
                                    _bio(snapshot.data.bio),
                                    _members(snapshot.data.members),
                                  ],
                                ),
                              ),
                              ConcertsView(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
              break;
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              return Text('');
          }
        },
      ),
    );
  }

  Widget _members(List<dynamic> members) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Members',
              style: TextStyle(fontSize: 18, color: primaryColor),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1,
              color: primaryColor,
            ),
          ),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
          padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
          height: 120,
          width: double.infinity,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _membersIndv(members[index]);
              },
              itemCount: members.length),
        ),
      ],
    );
  }

  Widget _membersIndv(Map<String, dynamic> members) {
    return Container(
      margin: EdgeInsets.all(5),
      height: double.infinity,
      width: 60,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
            child: Image.network(
              members['image'],
              height: 80,
              width: 55,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            members['member'],
            style:
                TextStyle(fontSize: 9, color: Color.fromRGBO(255, 255, 255, 1)),
          )
        ],
      ),
    );
  }

  Widget _sliverTopBar() {
    return SliverAppBar(
      backgroundColor: backgroundColor,
      leading: InkWell(
        child: Icon(Icons.arrow_back),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      expandedHeight: 250,
      flexibleSpace: FlexibleSpaceBar(
        background: _heroTop(),
      ),
      actions: [
        Icon(Icons.share),
        Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
      ],
    );
  }

  Widget _heroTop() {
    return Stack(
      children: [
        Container(
          child: Hero(
            tag: 'dash1',
            child: Image.network(
              artistMap['image'],
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          child: Positioned(
            left: 10,
            bottom: 5,
            child: Row(
              children: [
                Text(
                  artistMap['name'],
                  style: TextStyle(
                    fontSize: 28,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: IconButton(
                    onPressed: () {
                      _isLikedCheck();
                    },
                    icon: _isLiked
                        ? Icon(
                            Icons.favorite,
                            color: primaryColor,
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: primaryWhiteColor,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
          child: Text(artistNotifier.currentArtist.genre,
              style: TextStyle(fontSize: 18, color: primaryColor)),
        ),
      ],
    );
  }

  Widget _rating(var rating, var numRates) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 5, 30, 0),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Column(
            children: [
              Text(
                rating.toString() + '/10',
                style: TextStyle(fontSize: 18, color: primaryColor),
              ),
              Text(
                numRates.toString(),
                style: TextStyle(
                  fontSize: 11,
                  color: primaryWhiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bio(String descText) {
    return Container(
      margin: EdgeInsets.all(20),
      child: ExpandablePanel(
        // ignore: deprecated_member_use
        iconColor: Color.fromRGBO(242, 153, 74, 1),
        header: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Biography',
            style: TextStyle(
              fontSize: 18,
              color: primaryColor,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        collapsed: Text(
          descText,
          softWrap: true,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            color: Color.fromRGBO(255, 255, 255, 1),
            backgroundColor: backgroundColor,
          ),
        ),
        expanded: Text(
          descText,
          softWrap: true,
          style: TextStyle(
            fontSize: 12,
            color: Color.fromRGBO(255, 255, 255, 1),
            backgroundColor: backgroundColor,
          ),
        ),
      ),
    );
  }

  void _isLikedCheck() async {
    Favorite f = await database.getFavorite(artistMap['artistId']);
    if (f == null) {
      print('no entry found');
    }
    print('Entry was: ${f.toMap().toString()}');
    print(f.isFavorite);
    if (f.isFavorite) {
      savedArtist.remove();
      setState(() {
        _isLiked = false;
      });
      f.isFavorite = false;
      await database.updateFavorite(f);
    } else {
      setState(() {
        _isLiked = true;
      });
      f.isFavorite = true;
      await database.updateFavorite(f);
      savedArtist.add(f);
    }
  }

  void _checkForFavorite() async {
    Favorite f = await database.getFavorite(artistMap['artistId']);
    if (f == null) {
      f = Favorite(
          artistMap['artistId'], false, artistMap['image'], artistMap['name']);
      _isLiked = false;
      print('No entry found, inserted new');
      database.insertFavorite(f);
    } else {
      print('inital entry was: ${f.toMap().toString()}');
      if (f.isFavorite) {
        setState(() {
          _isLiked = true;
        });
      } else {
        setState(() {
          _isLiked = false;
        });
      }
    }
  }

  Future<Artist> _getArtist() async {
    print(artistMap['artistId']);
    return getArtist(artistMap['artistId']);
  }
}
