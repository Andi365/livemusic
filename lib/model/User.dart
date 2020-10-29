import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class User {
  User _user;

  String id = auth.currentUser.uid;
  String name = auth.currentUser.displayName;
  String email = auth.currentUser.email;
  bool isAnonymous = auth.currentUser.isAnonymous;
  String phone = auth.currentUser.phoneNumber;
  String photoUrl = auth.currentUser.photoURL;

  User get user => _user;
}
