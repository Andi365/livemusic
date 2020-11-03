import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:livemusic/api/rating_api.dart';
import 'package:livemusic/model/Rating.dart';
import 'package:livemusic/notifier/artist_notifier.dart';
import 'package:livemusic/notifier/rating_notifier.dart';
import 'package:provider/provider.dart';

import '../colors.dart';

class VotePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VotePage();
  }
}

class _VotePage extends State<VotePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Rating _rating;

  @override
  void initState() {
    ArtistNotifier artistNotifier =
        Provider.of<ArtistNotifier>(context, listen: false);
    RatingNotifier ratingNotifier =
        Provider.of<RatingNotifier>(context, listen: false);
    if (ratingNotifier.rating != null) {
      _rating = ratingNotifier.rating;
    } else {
      _rating = Rating();
      _rating.wasCreated = Timestamp.now();
    }
    super.initState();
  }

  _saveRating() {
    print('SaveRating Called');
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    print('form saved');

    uploadRating(_rating);

    print('map: ${_rating.toMap()}');

    print('timeStamp is: ${_rating.wasCreated}');
    print('UserID is: ${_rating.userId}');
    print('Rating is: ${_rating.rating}');
  }

  Widget _ratingField() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        style: TextStyle(color: primaryColor, fontSize: 16),
        decoration: InputDecoration(
          labelText: 'Rate from 0-10',
          //fillColor: primaryColor,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        validator: (String value) {
          if (value.isEmpty) {
            return 'Rating is required';
          }

          if (!value.contains(new RegExp(r'^[1]?[0-9]$'))) {
            return 'Please provide a rating from 1..10';
          }
          return null;
        },
        onSaved: (String value) {
          _rating.rating = int.parse(value);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ArtistNotifier artistNotifier = Provider.of<ArtistNotifier>(context);
    String currArtist = artistNotifier.currentArtist.name;
    // TODO: implement build
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
        title: Text(
          'Rate $currArtist',
          style: TextStyle(color: primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: [
              Image.network(artistNotifier.currentArtist.image),
              _ratingField(),
              RaisedButton(
                color: primaryColor,
                onPressed: () {
                  _saveRating();
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: primaryWhiteColor, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
