import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:livemusic/notifier/artist_notifier.dart';
import 'package:provider/provider.dart';

class HeroTop extends StatelessWidget {
  final String artistNameText;
  String _imageURL; 

  HeroTop(this.artistNameText);

  printUrl(ArtistNotifier artistNotifier) async {
    StorageReference ref = 
        FirebaseStorage.instance.ref().child("Bands/" + artistNotifier.currentArtist.image);
    String url = (await ref.getDownloadURL()).toString();
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    ArtistNotifier artistNotifier = Provider.of<ArtistNotifier>(context);
    FirebaseStorage storage = FirebaseStorage.instance;
    Future<StorageReference> storageReference = storage.getReferenceFromUrl(artistNotifier.currentArtist.image);
    
    return Container(
        width: double.infinity,
        //margin: EdgeInsets.all(10),
        //padding: EdgeInsets.only(left: 10),
        child: Stack(
          children: [
            Container(
              //alignment: Alignment.center,
              child: 
              Image.network(
                storageReference.toString(),
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
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
                    color: Color.fromRGBO(193, 160, 80, 1),
                  ),
                ),
              ),
            ),
          ],
        )
        /*Text(
        artistNameText, 
        
        ), */
        );
  }
}
