import 'package:flutter/material.dart';

class Bio extends StatelessWidget {
  final String descText;

  Bio(this.descText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            /*decoration: BoxDecoration(
              border: Border.all(10)
            ),*/
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Biography',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(193, 160, 80, 1),
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Text(
            descText,
            style: TextStyle(
              fontSize: 12,
              color: Color.fromRGBO(255, 255, 255, 1),
              backgroundColor: Color.fromRGBO(20, 20, 20, 1),
            ),
          ),
        ],
      ),
    );
  }
}
