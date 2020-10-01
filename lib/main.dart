import 'package:flutter/material.dart';

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
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Hello App'),
          ),
          body: Column(children: [
            Text('this is text + ' + _questionIndex.toString()),
            RaisedButton(child: Text('Hello'), onPressed: _answerChosen)
          ])),
    );
  }
}
