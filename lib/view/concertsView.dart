import 'package:flutter/material.dart';
import 'package:livemusic/notifier/concert_notifier.dart';
import 'package:livemusic/view/votePage.dart';

import '../colors.dart';

class ConcertsView extends StatelessWidget {
  const ConcertsView({
    Key key,
    @required this.concertNotifier,
  }) : super(key: key);

  final ConcertNotifier concertNotifier;

  @override
  Widget build(BuildContext context) {
    return concertNotifier.concertList.isNotEmpty
        ? ListView.separated(
            separatorBuilder: (_, __) => Divider(
                  height: 2,
                  color: primaryColor,
                  indent: 10,
                  endIndent: 10,
                ),
            itemCount: concertNotifier.concertList.length,
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
                              concertNotifier.concertList[index].venueId,
                              style: TextStyle(color: primaryColor),
                            ),
                            Text(
                              concertNotifier.concertList[index].date
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
                        concertNotifier.currentConcert =
                            concertNotifier.concertList[index];

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return VotePage();
                            },
                          ),
                        );
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
            })
        : Center(
            child: Text(
              'No concerts available',
              style: TextStyle(color: primaryColor, fontSize: 20),
            ),
          );
  }
}