import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:livemusic/model/colors.dart';
import 'package:livemusic/model/Artist.dart';
import 'package:livemusic/notifier/artist_notifier.dart';
import 'package:provider/provider.dart';

import '../api/artist_api.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  Future<List<Artist>> _artists;
  ArtistNotifier artistNotifier;

  @override
  void initState() {
    artistNotifier = Provider.of<ArtistNotifier>(context, listen: false);
    _artists = _getArtists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    artistNotifier = Provider.of<ArtistNotifier>(context);
    return Scaffold(
        backgroundColor: backgroundColor,
        body: FutureBuilder(
          future: _artists,
          builder: (context, AsyncSnapshot<List<Artist>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return SafeArea(
                  child: Container(
                    child: GridView.builder(
                      itemCount: artistNotifier.artistList.length,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 4),
                      itemBuilder: (context, _index) {
                        return InkWell(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(artistNotifier
                                              .artistList[_index].image),
                                          fit: BoxFit.cover)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomRight,
                                        colors: [
                                          Colors.black.withOpacity(.4),
                                          Colors.black.withOpacity(.2),
                                        ],
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          artistNotifier
                                              .artistList[_index].name,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  193, 160, 80, 1),
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            artistNotifier.currentArtist =
                                artistNotifier.artistList[_index];
                            Map<String, dynamic> map = {
                              "artistId": artistNotifier.currentArtist.id,
                              "image": artistNotifier.currentArtist.image,
                              "name": artistNotifier.currentArtist.name,
                            };
                            Navigator.of(context)
                                .pushNamed('/artist', arguments: map);
                          },
                        );
                      },
                      scrollDirection: Axis.vertical,
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
        ));
  }

  Future<List<Artist>> _getArtists() async {
    return getArtists(artistNotifier);
  }
}
