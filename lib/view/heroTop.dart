import 'package:flutter/material.dart';
import 'package:livemusic/notifier/artist_notifier.dart';

import '../colors.dart';

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
