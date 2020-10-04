import 'package:flutter/material.dart';

class Bio extends StatelessWidget {
  final String descText;

  Bio(this.descText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 5
        )
      ),
      child: 
        Text(
          descText,
          style: TextStyle(
            fontSize: 14,
            color: Color.fromRGBO(255, 255, 255, 1), 
            backgroundColor: Color.fromRGBO(20, 20, 20, 1)
          )
        ),
    );
  }
}