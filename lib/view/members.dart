import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livemusic/model/colors.dart';
import 'package:livemusic/controller/notifier/artist_notifier.dart';
import 'package:provider/provider.dart';

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
              style: TextStyle(fontSize: 18, color: primaryColor),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1,
              color: primaryColor,
            ),
          ),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
          padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
          height: 120,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _membersIndv(
                  (artistNotifier.currentArtist.members
                      .elementAt(index))['image'],
                  (artistNotifier.currentArtist.members
                      .elementAt(index))['member']);
            },
            itemCount: artistNotifier.currentArtist.members.length,
          ),
        ),
      ],
    );
  }
}

Widget _membersIndv(String image, String member) {
  return Container(
    margin: EdgeInsets.all(5),
    height: double.infinity,
    width: 60,
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
          child: Image.network(
            image,
            height: 80,
            width: 55,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          member,
          style:
              TextStyle(fontSize: 9, color: Color.fromRGBO(255, 255, 255, 1)),
        )
      ],
    ),
  );
}
