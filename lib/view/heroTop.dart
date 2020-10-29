import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:livemusic/colors.dart';
import 'package:livemusic/notifier/artist_notifier.dart';
import 'package:provider/provider.dart';

class HeroTop extends StatelessWidget {
  final String artistNameText;
  String _imageURL;

  HeroTop(this.artistNameText);

  @override
  Widget build(BuildContext context) {
    ArtistNotifier artistNotifier = Provider.of<ArtistNotifier>(context);

    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            child: Hero(
              tag: Text('Hello'),
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
                artistNameText,
                style: TextStyle(
                  fontSize: 28,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
