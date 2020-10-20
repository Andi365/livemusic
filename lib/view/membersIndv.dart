import 'package:flutter/material.dart';

class MembersIndv extends StatelessWidget {
  final String photoPath;
  final String name;

  MembersIndv(this.photoPath, this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: double.infinity,
      width: 60,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
            child: Image.asset(
              photoPath,
              height: 80,
              width: 55,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            name,
            style:
                TextStyle(fontSize: 9, color: Color.fromRGBO(255, 255, 255, 1)),
          )
        ],
      ),
    );
  }
}
