import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livemusic/api/rating_api.dart';
import 'package:livemusic/model/Rating.dart';
import 'package:livemusic/notifier/artist_notifier.dart';
import 'package:livemusic/notifier/concert_notifier.dart';
import 'package:livemusic/notifier/rating_notifier.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../colors.dart';

class VotePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VotePage();
  }
}

class _VotePage extends State<VotePage> {
  Rating _rating;
  bool _isButtonDisabled = true;

  isRatingFound() {
    setState(() {
      if (_rating.rating == null || _rating.rating == 0.0) {
        _isButtonDisabled = true;
      } else {
        _isButtonDisabled = false;
      }
    });
  }

  @override
  void initState() {
    ArtistNotifier artistNotifier =
        Provider.of<ArtistNotifier>(context, listen: false);
    RatingNotifier ratingNotifier =
        Provider.of<RatingNotifier>(context, listen: false);
    ConcertNotifier concertNotifier =
        Provider.of<ConcertNotifier>(context, listen: false);
    if (ratingNotifier.rating != null) {
      _rating = ratingNotifier.rating;
    } else {
      _rating = Rating();
      _rating.wasCreated = Timestamp.now();
      _rating.artistId = artistNotifier.currentArtist.id;
      _rating.artistName = artistNotifier.currentArtist.name;
      _rating.date = concertNotifier.currentConcert.date;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ArtistNotifier artistNotifier = Provider.of<ArtistNotifier>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Opacity(
                  opacity: 0.3,
                  child: Image.network(artistNotifier.currentArtist.image),
                ),
                Positioned.fill(
                  child: Align(
                    child: Text(
                      _rating.rating == null ? "" : '${_rating.rating}',
                      style: TextStyle(
                          color: primaryWhiteColor,
                          fontSize: 80,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 30, 10, 30),
                child: Text(
                  'How would you rate your concert with ${artistNotifier.currentArtist.name}?',
                  style: TextStyle(color: primaryWhiteColor, fontSize: 24),
                ),
              ),
            ),
              SmoothStarRating(
                color: primaryColor,
                borderColor: primaryWhiteColor,
                allowHalfRating: true,
                starCount: 10,
                size: MediaQuery.of(context).size.width/11,
                onRated: (double rating) {
                  setState(() {
                    _rating.rating = rating;
                    isRatingFound();
                  });
                },
              ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              width: double.infinity,
              child: RaisedButton(
                color: _isButtonDisabled ? Colors.grey[400] : primaryColor,
                onPressed: () {
                  uploadRating(_rating);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(5, 8, 5, 8),
                  child: Text(
                    'Rate',
                    style: _isButtonDisabled
                        ? TextStyle(
                            color: Colors.grey[100],
                            fontSize: 20,
                          )
                        : TextStyle(color: primaryWhiteColor, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
