import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livemusic/view/artist/artist_page.dart';
import 'package:livemusic/view/artist/concert_view.dart';
import 'package:livemusic/view/login/login_page.dart';
import 'package:livemusic/view/navigation/navigation_view.dart';
import 'package:livemusic/view/artist/vote_page.dart';

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
      case '/concert':
        return MaterialPageRoute(builder: (_) => ConcertView(args));
      default:
        return MaterialPageRoute(builder: (_) => Navigation());
    }
  }
}
