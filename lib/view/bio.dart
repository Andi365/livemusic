import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:livemusic/colors.dart';

class Bio extends StatelessWidget {
  final String descText;

  Bio(this.descText);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        child: ExpandablePanel(
          // ignore: deprecated_member_use
          iconColor: Color.fromRGBO(242, 153, 74, 1),
          header: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Biography',
              style: TextStyle(
                fontSize: 18,
                color: primaryColor,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          collapsed: Text(
            descText,
            softWrap: true,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Color.fromRGBO(255, 255, 255, 1),
              backgroundColor: backgroundColor,
            ),
          ),
          expanded: Text(
            descText,
            softWrap: true,
            style: TextStyle(
              fontSize: 12,
              color: Color.fromRGBO(255, 255, 255, 1),
              backgroundColor: backgroundColor,
            ),
          ),
        ),
    );
  }
}
