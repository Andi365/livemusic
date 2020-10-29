import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:livemusic/notifier/artist_notifier.dart';
import 'package:livemusic/notifier/rating_notifier.dart';
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
      backgroundColor: Color.fromRGBO(20, 20, 20, 1),
      body: Container(
        child: GridView.builder(
          itemCount: artistNotifier.artistList.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 4),
          itemBuilder: (context, index) {
            return Hero(
              tag: Text('Hello'),
              child: InkWell(
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 3),
                        child: Image.network(
                          artistNotifier.artistList[index].image,
                          height: 100,
                          width: 200,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                        artistNotifier.artistList[index].name,
                        style: TextStyle(
                            color: Color.fromRGBO(193, 160, 80, 1),
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  artistNotifier.currentArtist =
                      artistNotifier.artistList[index];
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ArtistPage();
                      },
                    ),
                  );
                },
              ),
            );
          },
          //shrinkWrap: true,
          scrollDirection: Axis.vertical,
          /*crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                children: [artistNotifier.artistList.image],*/
        ),
      ),
    );
    /*ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(artistNotifier.artistList[index].name),
                  onTap: () {
                    artistNotifier.currentArtist =
                        artistNotifier.artistList[index];
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
              itemCount: artistNotifier.artistList.length),*/
  }
}
