import 'package:flutter/material.dart';
import 'package:livemusic/notifier/artist_notifier.dart';
import 'package:provider/provider.dart';

import 'heroTop.dart';
import 'bio.dart';
import 'navigation.dart';
import 'members.dart';
import 'rating.dart';

class ArtistPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ArtistPage();
  }
}

class _ArtistPage extends State<ArtistPage> {
  @override
  Widget build(BuildContext context) {
    ArtistNotifier artistNotifier = Provider.of<ArtistNotifier>(context);

    var _artist = artistNotifier.currentArtist.name;
    var _desc = artistNotifier.currentArtist.bio;

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(20, 20, 20, 1),
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          actions: [
            Icon(Icons.share),
            Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
          ],
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              HeroTop(_artist.toString()),
              Rating(7.5, 3543),
              Bio(_desc),
              Members()
            ],
          ),
        ),
      ),
    );
  }
}
