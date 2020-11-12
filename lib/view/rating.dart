import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livemusic/colors.dart';

class Rating extends StatelessWidget {
  var rating;
  String ratingString;
  final int numRates;
  bool rated = false;

  Rating(this.rating, this.numRates);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.fromLTRB(30, 5, 30, 0),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(
              children: [
                Text(
                  rating.toString() + '/10',
                  style: TextStyle(fontSize: 18, color: primaryColor),
                ),
                Text(
                  numRates.toString(),
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryWhiteColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
