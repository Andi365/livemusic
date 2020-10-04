import 'package:flutter/material.dart';

import './heroTop.dart';
import './bio.dart';
import './navigation.dart';

void main() {
  runApp(MyApp());
}

var _questionIndex = 0;

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  void _answerChosen() {
    setState(() {
      _questionIndex++;
    });
    print(_questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    var _artist = 'Arctic monkeys';
    var _desc =
        'Let\'s go down, down low down Where I know I should not go Oh, and she thinks she\'s the one But she\'s just one in twenty-four And just cause everybody\'s doing it Does that mean that I can, too?';

    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
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
              RaisedButton(child: Text('Hello'), onPressed: _answerChosen)
            ],
          ),
          bottomNavigationBar: Navigation()),
    );
  }
}
