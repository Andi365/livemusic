import 'package:flutter/material.dart';
import 'package:livemusic/api/signIn_api.dart';

import 'package:livemusic/model/colors.dart';
import 'package:livemusic/model/user.dart';
import 'package:livemusic/controller/notifier/navigation_notifier.dart';
import 'package:livemusic/controller/notifier/rating_notifier.dart';
import 'package:livemusic/api/rating_api.dart';
import 'package:livemusic/view/login/login_page.dart';
import 'package:provider/provider.dart';

import '../../model/colors.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Profilepage();
  }
}

class _Profilepage extends State<ProfilePage> {
  bool _isAno = false;
  @override
  void initState() {
    RatingNotifier ratingNotifier =
        Provider.of<RatingNotifier>(context, listen: false);
    if (auth.currentUser.isAnonymous) {
      _isAno = true;
    }
    if (ratingNotifier.ratingList.isEmpty && !auth.currentUser.isAnonymous) {
      getIndvRatings(auth.currentUser.uid, ratingNotifier);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NavigationNotifer navigationNotifer =
        Provider.of<NavigationNotifer>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: _isAno
          ? LoginPage()
          : CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  backgroundColor: backgroundColor,
                  leading: InkWell(
                    child: Icon(Icons.arrow_back),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Center(
                          heightFactor: 1.5,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                auth.currentUser.photoURL.toString()),
                            radius: 50.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Text(
                          auth.currentUser.displayName,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Color.fromRGBO(193, 160, 80, 1),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Card(
                          color: primaryWhiteColor,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Ratings',
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '54',
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 18,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Followers',
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '25',
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 18,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Following',
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '20',
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 18,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: RaisedButton(
                          color: primaryColor,
                          onPressed: () {
                            signOut().then((value) =>
                                Navigator.pushNamedAndRemoveUntil(context,
                                    '/login', ModalRoute.withName('/login')));
                            navigationNotifer.currentIndex = 0;
                          },
                          child: Text(
                            'Sign out',
                            style: TextStyle(
                                fontSize: 10,
                                color: primaryWhiteColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
