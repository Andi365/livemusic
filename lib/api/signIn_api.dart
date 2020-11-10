import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');

    return '$user';
  }

  return null;
}

Future<void> signInWithEmail(String name, String email, String password) async {
  final FirebaseAuth auth = FirebaseAuth.instance;

  await auth.createUserWithEmailAndPassword(email: email, password: password);

  await auth.currentUser.updateProfile(
      displayName: name,
      photoURL:
          'https://lh4.googleusercontent.com/-na_Bj3-n2Wc/AAAAAAAAAAI/AAAAAAAAAAA/AMZuuck455IkCMkdqgitXtg-XizYWGROyQ/s96-c/photo.jpg');

  final User user = auth.currentUser;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null, 'ID token is null');

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('Signin with Email succeeded: $user');

    print('$user');
  }

  CollectionReference ratingRef =
      FirebaseFirestore.instance.collection('users');

  await ratingRef.doc(auth.currentUser.uid).set({'name': name});

  print('Created ${user.displayName}');
}

/*Future<String> signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult result = await FacebookAuth.instance.login();

  // Create a credential from the access token
  final FacebookAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(result.accessToken.token);

  final UserCredential authResult =
      await _auth.signInWithCredential(facebookAuthCredential);
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithFacebook succeeded: $user');

    return '$user';
  }

  return null;
}*/

Future<String> signInAnonymously() async {
  final UserCredential authResult = await _auth.signInAnonymously();
  final User user = authResult.user;

  if (user != null) {
    assert(user.isAnonymous);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInAnonymously succeeded: $user');

    return '$user';
  }

  return null;
}

Future<void> signOut() async {
  await _auth.signOut();

  print("User Signed Out");
}

/*Future<void> signOutFacebook() async {
  await _auth.signOut();

  print("User Signed Out");
}*/
