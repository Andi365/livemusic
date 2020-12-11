import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final String image, artistName, artistId;

  const CardView(this.image, this.artistName, {this.artistId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
        child: Column(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(.4),
                      Colors.black.withOpacity(.2),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      artistName,
                      style: TextStyle(
                          color: Color.fromRGBO(193, 160, 80, 1), fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Map<String, dynamic> map = {
          "artistId": artistId,
          "image": image,
          "name": artistName
        };
        Navigator.of(context).pushNamed('/artist', arguments: map);
      },
    );
  }
}
