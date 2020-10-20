import 'package:flutter/material.dart';

class HeroTop extends StatelessWidget {
  final String artistNameText;

  HeroTop(this.artistNameText);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        //margin: EdgeInsets.all(10),
        //padding: EdgeInsets.only(left: 10),
        child: Stack(
          children: [
            Container(
              //alignment: Alignment.center,
              child: Image.asset(
                'assets/images/arctic_mokeys.jpg',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: Positioned(
                left: 10,
                bottom: 5,
                child: Text(
                  artistNameText,
                  style: TextStyle(
                    fontSize: 28,
                    color: Color.fromRGBO(193, 160, 80, 1),
                  ),
                ),
              ),
            ),
          ],
        )
        /*Text(
        artistNameText, 
        
        ), */
        );
  }
}
