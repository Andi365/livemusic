import 'package:flutter/material.dart';
import 'package:livemusic/api/signIn_api.dart';

import 'package:livemusic/model/colors.dart';
import 'package:livemusic/model/User.dart';
import 'package:livemusic/notifier/navigation_notifier.dart';
import 'package:livemusic/notifier/rating_notifier.dart';
import 'package:livemusic/api/rating_api.dart';
import 'package:livemusic/view/loginpage.dart';
import 'package:provider/provider.dart';

import '../model/colors.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Profilepage();
  }
}

int perPage = 3;
int present = 0;
List<double> ratings = List<double>();
List<String> bands = List<String>();
List<String> dates = List<String>();
var items = List<double>();

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
      //print("HEJHEJHEJ");
      //print('init list: ${ratingNotifier.ratingList.toString()}');
    }
    super.initState();
  }

  /*void setTheDamnState() {
    RatingNotifier ratingNotifier =
        Provider.of<RatingNotifier>(context, listen: false);
    setState(() {
      for (int i = 0; i < ratingNotifier.ratingList.length; i++) {
        ratings.add(ratingNotifier.ratingList[i].rating);
        bands.add(ratingNotifier.ratingList[i].artistName.toString());
        dates.add(ratingNotifier.ratingList[i].date.toDate().toString());
      }

      for (int i = 0; i < ratings.length; i++) {
        print("Today is the day i debug like a motherfucker " +
            ratings[i].toString());
      }
      items.addAll(ratings.getRange(present, present + perPage));
      present = present + perPage;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    NavigationNotifer navigationNotifer =
        Provider.of<NavigationNotifer>(context);
    //setTheDamnState();
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
                      /*Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text("My reviews",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                          )),
                    ),
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                        itemCount: (present <= ratings.length)
                            ? items.length + 1
                            : items.length,
                        itemBuilder: (context, index) {
                          return (index == items.length)
                              ? Container(
                                  color: primaryColor,
                                  child: FlatButton(
                                    child: Text("Load More"),
                                    onPressed: () {
                                      setState(() {
                                        if ((present + perPage) >
                                            ratings.length) {
                                          items.addAll(ratings.getRange(
                                              present, ratings.length));
                                        } else {
                                          items.addAll(ratings.getRange(
                                              present, present + perPage));
                                        }
                                        present = present + perPage;
                                      });
                                    },
                                  ),
                                )
                              : ListTile(
                                  leading: Icon(Icons.star,
                                      color: primaryColor, size: 30.0),
                                  tileColor: Color.fromRGBO(5, 5, 5, 5),
                                  title: Text(
                                    '${items[index]}/10.0',
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    '${bands[index]}' + " " + '${dates[index]}',
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 10),
                                  ),
                                  dense: true,
                                );
                        },
                      ),
                    )
                  ],
                ),*/
                    ],
                  ),
                ),
                /*SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                      ),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            child: Expanded(
                              child: Text(
                                '${ratingNotifier.ratingList[index].rating.toString()}/10',
                                style: TextStyle(
                                    color: primaryColor, fontSize: 20),
                              ),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    ratingNotifier.ratingList[index].artistName,
                                    style: TextStyle(
                                        color: primaryWhiteColor, fontSize: 16),
                                  ),
                                  Text(
                                    'Date: ${ratingNotifier.ratingList[index].date.toDate().toString()}',
                                    style: TextStyle(
                                        color: primaryWhiteColor, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
              childCount: ratingNotifier.ratingList.length,
            ),
          ),*/
              ],
            ),
    );
  }
}
