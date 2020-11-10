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
      backgroundColor: Color.fromRGBO(20, 20, 20, 1),
      body: SafeArea(
        child: Container(
          child: GridView.builder(
            itemCount: artistNotifier.artistList.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 4),
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
                                image: NetworkImage(
                                    artistNotifier.artistList[_index].image),
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
                                artistNotifier.artistList[_index].name,
                                style: TextStyle(
                                    color: Color.fromRGBO(193, 160, 80, 1),
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ArtistPage(_index);
                      },
                    ),
                  );
                },
              );
            },

            /*Container(
                child: Padding(
                  padding: null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 3),
                        child: Hero(
                          tag: 'dash$_index',
                          child: Image.network(
                            artistNotifier.artistList[_index].image,
                            height: 100,
                            width: 200,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Text(
                        artistNotifier.artistList[_index].name,
                        style: TextStyle(
                            color: Color.fromRGBO(193, 160, 80, 1),
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ), */
            //shrinkWrap: true,
            scrollDirection: Axis.vertical,
            /*crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                children: [artistNotifier.artistList.image],*/
          ),
        ),
      ),
    );
  }
}
