import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:livemusic/notifier/artist_notifier.dart';
import 'package:provider/provider.dart';

import 'heroTop.dart';
import 'bio.dart';
import 'navigation.dart';
import 'members.dart';
import 'rating.dart';

class ArtistPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ArtistPage();
  }
}

class _ArtistPage extends State<ArtistPage> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
    });
    print(_selectedItem);
  }

  void _answerChosen() {
    setState(() {
      _questionIndex++;
    });
    print(_questionIndex);
  }

  var _questionIndex = 0;
  var _selectedItem = 0;
  CollectionReference artist = FirebaseFirestore.instance.collection('Artist');
  final firestoreInstance = FirebaseFirestore.instance;
  User user = FirebaseAuth.instance.currentUser;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    ArtistNotifier artistNotifier = Provider.of<ArtistNotifier>(context);
    var _artist = 'Arctic Monkeys';

    //var _artist = 'Arctic Monkeys';

    var _desc =
        'Let\'s go down, down low down Where I know I should not go Oh, and she thinks she\'s the one But she\'s just one in twenty-four And just cause everybody\'s doing it Does that mean that I can, too?';

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      home: Scaffold(
        backgroundColor: Color.fromRGBO(20, 20, 20, 1),
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          //title: Text(''),
          actions: [
            Icon(Icons.share),
            Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
          ],
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              HeroTop(_artist.toString()),
              Rating(7.5, 3543),
              Bio(_desc),
              /*RaisedButton(
                child: Text('test'),
                onPressed: _answerChosen,
              ),*/
              Members()
            ],
          ),
        ),
        bottomNavigationBar: Navigation(_onItemTapped, _selectedItem),
      ),
    );
  }
}
