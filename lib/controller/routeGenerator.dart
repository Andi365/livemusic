import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livemusic/view/artistPage.dart';
import 'package:livemusic/view/loginpage.dart';
import 'package:livemusic/view/navigation.dart';
import 'package:livemusic/view/votePage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Navigation());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/votepage':
        return MaterialPageRoute(builder: (_) => VotePage());
      case '/artist':
        return MaterialPageRoute(builder: (_) => ArtistPage(args));
      default:
        return MaterialPageRoute(builder: (_) => Navigation());
    }
  }
}
