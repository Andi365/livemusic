import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livemusic/notifier/artist_notifier.dart';
import 'package:provider/provider.dart';

import 'membersIndv.dart';

class Members extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ArtistNotifier artistNotifier = Provider.of<ArtistNotifier>(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Members',
              style: TextStyle(
                  fontSize: 18, color: Color.fromRGBO(193, 160, 80, 1)),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1,
              color: Color.fromRGBO(193, 160, 80, 1),
            ),
          ),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
          padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
          height: 120,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return MembersIndv(
                (artistNotifier.currentArtist.members
                    .elementAt(index))['image'],
                (artistNotifier.currentArtist.members
                    .elementAt(index))['member'],
              );
            },
            itemCount: artistNotifier.currentArtist.members.length,
          ),
        ),
      ],
    );
  }
}
