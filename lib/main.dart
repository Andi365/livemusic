import 'package:flutter/material.dart';
import 'package:livemusic/notifier/artist_notifier.dart';
import 'package:livemusic/notifier/navigation_notifier.dart';
import 'package:livemusic/notifier/rating_notifier.dart';
import 'package:provider/provider.dart';

import 'view/loginpage.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ArtistNotifier(),
          ),
          ChangeNotifierProvider(
            create: (context) => NavigationNotifer(),
          ),
          ChangeNotifierProvider(
            create: (context) => RatingNotifier(),
          ),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
