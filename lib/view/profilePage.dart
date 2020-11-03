import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:livemusic/colors.dart';
import 'package:livemusic/model/User.dart';
import 'package:livemusic/notifier/rating_notifier.dart';
import 'package:livemusic/api/rating_api.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Profilepage();
  }
}

class _Profilepage extends State<ProfilePage> {
  @override
  void initState() {
    RatingNotifier ratingNotifier =
        Provider.of<RatingNotifier>(context, listen: false);
    if (ratingNotifier.ratingList.isEmpty) {
      getIndvRatings(auth.currentUser.uid, ratingNotifier);
      print('init list: ${ratingNotifier.ratingList.toString()}');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RatingNotifier ratingNotifier = Provider.of<RatingNotifier>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Center(
                heightFactor: 1.5,
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage(auth.currentUser.photoURL.toString()),
                  radius: 50.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                auth.currentUser.displayName,
                style: TextStyle(
                  fontSize: 22.0,
                  color: Color.fromRGBO(193, 160, 80, 1),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Card(
                color: primaryWhiteColor,
                child: Container(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Ratings',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '54',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Followers',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '25',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Following',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '20',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My Reviews',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                            ),
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                  child: Expanded(
                                    child: Text(
                                      '${ratingNotifier.ratingList[index].rating.toString()}/10',
                                      style: TextStyle(
                                          color: primaryColor, fontSize: 20),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Expanded(
                                    child: Text(
                                      ratingNotifier.ratingList[index].name,
                                      style: TextStyle(
                                          color: primaryWhiteColor,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                    childCount: ratingNotifier.ratingList.length,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
