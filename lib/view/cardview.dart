import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final String image, artistName;
  final int index;

  CardView(this.image, this.artistName, this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.cover)),
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
        //artistNotifier.currentArtist = artistNotifier.artistList[_index];
        Navigator.of(context).pushNamed('/artist', arguments: index);
      },
    );
  }
}
