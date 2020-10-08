import 'package:flutter/material.dart';

import './heroTop.dart';
import './bio.dart';
import './navigation.dart';

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

  @override
  Widget build(BuildContext context) {
    var _artist = 'Arctic monkeys';
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
          body: Column(
            children: [
              HeroTop(_artist),
              Bio(_desc),
              RaisedButton(child: Text('test'), onPressed: _answerChosen,)
            ],
          ),
          bottomNavigationBar: Navigation(_onItemTapped, _selectedItem),
      ),
    );
  }
}
