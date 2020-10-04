import 'package:flutter/material.dart';

class Bio extends StatelessWidget {
  final String descText;

  Bio(this.descText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(descText,
          style: TextStyle(
              fontSize: 12,
              color: Color.fromRGBO(255, 255, 255, 1),
              backgroundColor: Color.fromRGBO(20, 20, 20, 1))),
    );
  }
}
