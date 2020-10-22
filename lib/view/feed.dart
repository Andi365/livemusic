import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:livemusic/notifier/artist_notifier.dart';
import 'package:provider/provider.dart';

import '../api/artist_api.dart';
import 'artistPage.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  void initState() {
    ArtistNotifier artistNotifier =
        Provider.of<ArtistNotifier>(context, listen: false);
    getArtists(artistNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ArtistNotifier artistNotifier = Provider.of<ArtistNotifier>(context);
    return Scaffold(
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(artistNotifier.artistList[index].name),
              onTap: () {
                artistNotifier.currentArtist = artistNotifier.artistList[index];
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return ArtistPage();
                  },
                ));
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.black,
            );
          },
          itemCount: artistNotifier.artistList.length),
    );
  }
}
