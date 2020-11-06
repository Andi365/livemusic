import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:livemusic/api/concert_api.dart';
import 'package:livemusic/api/database_api.dart';
import 'package:livemusic/colors.dart';
import 'package:livemusic/notifier/artist_notifier.dart';
import 'package:livemusic/notifier/concert_notifier.dart';
import 'package:provider/provider.dart';

import 'bio.dart';
import 'members.dart';
import 'rating.dart';

class ArtistPage extends StatefulWidget {
  int index;

  @override
  State<StatefulWidget> createState() {
    return _ArtistPage();
  }

  ArtistPage(this.index);
}

class _ArtistPage extends State<ArtistPage> {
  bool _isLiked = false;
  DatabaseAPI database = DatabaseAPI.instance;

  void _isLikedCheck(
      BuildContext context, ArtistNotifier artistNotifier) async {
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

  void _check(BuildContext context, ArtistNotifier artistNotifier) async {
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
    ConcertNotifier concertNotifier =
        Provider.of<ConcertNotifier>(context, listen: false);
    _check(context, artistNotifier);
    getConcerts(artistNotifier.currentArtist.id, concertNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ArtistNotifier artistNotifier = Provider.of<ArtistNotifier>(context);
    ConcertNotifier concertNotifier = Provider.of<ConcertNotifier>(context);
    var _desc = artistNotifier.currentArtist.bio;
    var _rating = artistNotifier.currentArtist.rating;
    int _index = widget.index;

    print('artist id: ${artistNotifier.currentArtist.id}');

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (context, _) {
                return [
                  MySliverAppBar(
                      index: _index,
                      artistNotifier: artistNotifier,
                      isLiked: _isLiked,
                      isLikedCheck: _isLikedCheck),
                  Rating(_rating, 3543)
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
      ),
    );
  }
}

class ConcertsView extends StatelessWidget {
  const ConcertsView({
    Key key,
    @required this.concertNotifier,
  }) : super(key: key);

  final ConcertNotifier concertNotifier;

  @override
  Widget build(BuildContext context) {
    return concertNotifier.concertList.isNotEmpty
        ? ListView.separated(
            separatorBuilder: (_, __) => Divider(
                  height: 2,
                  color: primaryColor,
                  indent: 10,
                  endIndent: 10,
                ),
            itemCount: concertNotifier.concertList.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(5, 5, 0, 10),
                        child: Column(
                          children: [
                            Text(
                              concertNotifier.concertList[index].venueId,
                              style: TextStyle(color: primaryColor),
                            ),
                            Text(
                              concertNotifier.concertList[index].date
                                  .toDate()
                                  .toString(),
                              style: TextStyle(color: primaryWhiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        concertNotifier.currentConcert =
                            concertNotifier.concertList[index];
                      },
                      color: primaryColor,
                      child: Row(
                        children: [
                          Text(
                            'Rate',
                            style: TextStyle(
                                fontSize: 10,
                                color: primaryWhiteColor,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
                          Icon(
                            Icons.star,
                            color: primaryWhiteColor,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            })
        : Center(
            child: Text(
              'No concerts available',
              style: TextStyle(color: primaryColor, fontSize: 20),
            ),
          );
  }
}

class MySliverAppBar extends StatelessWidget {
  const MySliverAppBar({
    @required this.index,
    @required this.artistNotifier,
    this.isLiked,
    this.isLikedCheck,
  });

  final int index;
  final bool isLiked;
  final ArtistNotifier artistNotifier;
  final Function isLikedCheck;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: backgroundColor,
      leading: InkWell(
        child: Icon(Icons.arrow_back),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        background: HeroTop(
            index: index,
            artistNotifier: artistNotifier,
            isLiked: isLiked,
            isLikedCheck: isLikedCheck),
      ),
      actions: [
        Icon(Icons.share),
        Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
      ],
    );
  }
}

class HeroTop extends StatelessWidget {
  HeroTop(
      {@required int index,
      @required this.artistNotifier,
      this.isLiked,
      this.isLikedCheck});

  final ArtistNotifier artistNotifier;
  int index;
  final isLiked;
  final Function isLikedCheck;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Hero(
            tag: 'dash$index',
            child: Image.network(
              artistNotifier.currentArtist.image,
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
                  artistNotifier.currentArtist.name,
                  style: TextStyle(
                    fontSize: 28,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: IconButton(
                    onPressed: () {
                      isLikedCheck(context, artistNotifier);
                    },
                    icon: isLiked
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
}
