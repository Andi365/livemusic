import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:livemusic/colors.dart';
import 'package:livemusic/notifier/artist_notifier.dart';
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
  @override
  Widget build(BuildContext context) {
    ArtistNotifier artistNotifier = Provider.of<ArtistNotifier>(context);
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
          child: DefaultTabController(length: 2, child: NestedScrollView(headerSliverBuilder: (context, _) {
            return [SliverAppBar(
                backgroundColor: backgroundColor,
                leading: InkWell(
                  child: Icon(Icons.arrow_back),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  background:
                      HeroTop(index: _index, artistNotifier: artistNotifier),
                ),
                actions: [
                  Icon(Icons.share),
                  Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                ],
              ),
              Rating(_rating, 3543)];
          }, body: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: 'Info'), 
                  Tab(text: 'Concerts'),
                ],
              ),
              Expanded(child: TabBarView(children: [
                  SingleChildScrollView(child: Column(
                      children: [
                        Bio(_desc),
                        Members(),
                      ],
                    ),
                  ),
                  Text('data'),
                ],),),
            ],
          ),
        ),
        ),
      ),
      ),
    );
  }
}

class HeroTop extends StatelessWidget {
  HeroTop({
    Key key,
    @required int index,
    @required this.artistNotifier,
  }) : super(key: key);

  final ArtistNotifier artistNotifier;
  int index;

  @override
  Widget build(BuildContext context) {
    //timeDilation = 1.0;
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
            child: Text(
              artistNotifier.currentArtist.name,
              style: TextStyle(
                fontSize: 28,
                color: primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
