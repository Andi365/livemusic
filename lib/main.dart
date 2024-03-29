import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:livemusic/controller/route_generator.dart';
import 'package:livemusic/controller/notifier/artist_notifier.dart';
import 'package:livemusic/controller/notifier/concert_notifier.dart';
import 'package:livemusic/controller/notifier/navigation_notifier.dart';
import 'package:livemusic/controller/notifier/rating_notifier.dart';
import 'package:livemusic/controller/notifier/saved_artists_notifier.dart';
import 'package:livemusic/controller/notifier/saved_bookmarks_notifier.dart';
import 'package:provider/provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(
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
        ChangeNotifierProvider(
          create: (context) => ConcertNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => SavedArtistsNotifer(),
        ),
        ChangeNotifierProvider(
          create: (context) => SavedBookmarksNotifer(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SavedArtistsNotifer savedArtistsNotifer =
        Provider.of<SavedArtistsNotifer>(context, listen: false);
    SavedBookmarksNotifer savedBookmarksNotifer =
        Provider.of<SavedBookmarksNotifer>(context, listen: false);
    savedArtistsNotifer.loadData();
    savedBookmarksNotifer.loadData();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live music',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
