import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:livemusic/notifier/concert_notifier.dart';

import '../colors.dart';

class ConcertsView extends StatelessWidget {
  ConcertsView({
    Key key,
    @required this.concertNotifier,
  }) : super(key: key);

  final ConcertNotifier concertNotifier;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    TabController _tabController;
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [SliverToBoxAdapter(child: Text(' '))];
        },
        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              indicatorColor: primaryColor,
              labelColor: primaryColor,
              unselectedLabelColor: primaryWhiteColor,
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              tabs: [
                Tab(text: 'Upcoming'),
                Tab(text: 'Previous'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: concertNotifier.upcomingConcerts.isNotEmpty
                        ? _concertList(true)
                        : _noConcert(),
                  ),
                  SingleChildScrollView(
                    child: concertNotifier.previousConcerts.isNotEmpty
                        ? _concertList(false)
                        : _noConcert(),
                  )
                ],
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _concertList(bool upcomingOrPrevious) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) => Divider(
        height: 2,
        color: primaryColor,
        indent: 10,
        endIndent: 10,
      ),
      itemCount: upcomingOrPrevious
          ? concertNotifier.upcomingConcerts.length
          : concertNotifier.previousConcerts.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 0, 10),
                  child: Column(
                    children: [
                      Text(
                        upcomingOrPrevious
                            ? concertNotifier.upcomingConcerts[index].venueName
                            : concertNotifier.previousConcerts[index].venueName,
                        style: TextStyle(color: primaryColor),
                      ),
                      Text(
                        upcomingOrPrevious
                            ? concertNotifier.upcomingConcerts[index].date
                                .toDate()
                                .toString()
                            : concertNotifier.previousConcerts[index].date
                                .toDate()
                                .toString(),
                        style: TextStyle(color: primaryWhiteColor),
                      ),
                    ],
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  concertNotifier.currentConcert = upcomingOrPrevious
                      ? concertNotifier.upcomingConcerts[index]
                      : concertNotifier.previousConcerts[index];
                  if (auth.currentUser.isAnonymous) {
                    Navigator.of(context).popAndPushNamed('/votepage');
                  } else {
                    Navigator.of(context).pushNamed('/votepage');
                  }
                },
                color: primaryColor,
                child: Row(
                  children: [
                    Text(
                      'Rate',
                      style: TextStyle(
                          fontSize: 10,
                          color: primaryWhiteColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
                    Icon(
                      Icons.star,
                      color: primaryWhiteColor,
                      size: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _noConcert() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 15),
        child: Text(
          'No concerts available',
          style: TextStyle(color: primaryColor, fontSize: 20),
        ),
      ),
    );
  }
}
