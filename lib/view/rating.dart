import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livemusic/colors.dart';
import 'package:livemusic/view/votePage.dart';

class Rating extends StatelessWidget {
  final double rating;
  String ratingString;
  final int numRates;
  bool rated = false;

  Rating(this.rating, this.numRates);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(30, 5, 30, 0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      rating.toString() + '/10',
                      style: TextStyle(fontSize: 18, color: primaryColor),
                    ),
                    //Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
                    //Icon(Icons.star, color: Color.fromRGBO(193, 160, 80, 1))
                  ],
                ),
                Text(
                  numRates.toString(),
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryWhiteColor,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 50,
            child: Align(
              alignment: Alignment.center,
              child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return VotePage();
                        },
                      ),
                    );
                  },
                  color: primaryColor,
                  child: Row(
                    children: [
                      Text(
                        'Rate',
                        style: TextStyle(
                            fontSize: 10,
                            color: primaryWhiteColor,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
                      Icon(
                        Icons.star,
                        color: !rated ? primaryWhiteColor : primaryColor,
                        size: 20,
                      )
                    ],
                  )),
            ),
          ),
          Expanded(
            child: Container(
              height: 50,
              child: Align(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  onPressed: () {},
                  color: primaryColor,
                  child: Text(
                    'Upcoming Concerts',
                    style: TextStyle(fontSize: 10, color: primaryWhiteColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
