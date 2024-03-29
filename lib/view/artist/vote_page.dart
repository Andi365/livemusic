import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livemusic/api/rating_api.dart';
import 'package:livemusic/model/rating.dart';
import 'package:livemusic/controller/notifier/artist_notifier.dart';
import 'package:livemusic/controller/notifier/concert_notifier.dart';
import 'package:livemusic/controller/notifier/rating_notifier.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../model/colors.dart';

class VotePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VotePage();
  }
}

class _VotePage extends State<VotePage> {
  Rating _rating;
  bool _isButtonDisabled = true;

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
      _rating = Rating(
          artistNotifier.currentArtist.name,
          concertNotifier.currentConcert.date,
          artistNotifier.currentArtist.id,
          Timestamp.now());
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
          child: Icon(Icons.close),
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
                  child: Image.network(
                    artistNotifier.currentArtist.image,
                    height: 350,
                    width: double.infinity,
                  ),
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
              size: MediaQuery.of(context).size.width / 11,
              onRated: (double rating) {
                setState(() {
                  _rating.rating = rating;
                  _isRatingFound();
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
                  Navigator.pop(context);
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

  void _isRatingFound() {
    setState(() {
      if (_rating.rating == null || _rating.rating == 0.0) {
        _isButtonDisabled = true;
      } else {
        _isButtonDisabled = false;
      }
    });
  }
}
