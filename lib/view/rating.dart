import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final double rating;
  String ratingString;
  final int numRates;

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
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      rating.toString() + '/10',
                      style: TextStyle(
                          fontSize: 18, color: Color.fromRGBO(193, 160, 80, 1)),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
                    Icon(Icons.star, color: Color.fromRGBO(193, 160, 80, 1))
                  ],
                ),
                Text(
                  numRates.toString(),
                  style: TextStyle(
                    fontSize: 11,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 50,
              child: Align(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  onPressed: () {},
                  color: Color.fromRGBO(193, 160, 80, 1),
                  child: Text(
                    'Upcoming Concerts',
                    style: TextStyle(
                        fontSize: 9, color: Color.fromRGBO(255, 255, 255, 1)),
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
