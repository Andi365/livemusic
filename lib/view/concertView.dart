import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:livemusic/api/concert_api.dart';
import 'package:livemusic/model/Concert.dart';
import 'package:livemusic/model/colors.dart';
import 'package:livemusic/model/Venue.dart';

class ConcertView extends StatefulWidget {
  final Map<String, dynamic> map;

  @override
  State<StatefulWidget> createState() => _ConcertsView();

  ConcertView(this.map);
}

class _ConcertsView extends State<ConcertView> {
  Completer<GoogleMapController> _controller = Completer();
  Map<String, dynamic> _venueMap;
  Future<Venue> _venueFuture;
  Future<Concert> _concertFuture;

  @override
  void initState() {
    super.initState();
    _venueMap = widget.map;
    _venueFuture = _getVenue();
    _concertFuture = _getConcert();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _venueFuture,
      builder: (context, AsyncSnapshot<Venue> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                backgroundColor: backgroundColor,
                title: Text('Concert at ${snapshot.data.name}'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 400,
                      child: GoogleMap(
                        mapType: MapType.hybrid,
                        initialCameraPosition: _cameraPosition(
                            snapshot.data.coordinates.latitude,
                            snapshot.data.coordinates.longitude),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                    FutureBuilder(
                      future: _concertFuture,
                      builder: (context, AsyncSnapshot<Concert> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.done:
                            return _info(snapshot);
                            break;
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());
                          default:
                            return Text('');
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
            break;
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            return Text('');
        }
      },
    );
  }

  Widget _info(AsyncSnapshot<Concert> snapshot) {
    return snapshot.hasData
        ? Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: primaryColor,
                indent: 20,
                endIndent: 20,
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, left: 20),
                child: Text(
                  'Playing Artist: ${snapshot.data.name}',
                  style: TextStyle(fontSize: 18, color: primaryColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, left: 20),
                child: Text(
                  'Date: ${_formatTime(snapshot.data.date)}',
                  style: TextStyle(fontSize: 18, color: primaryColor),
                ),
              )
            ],
          )
        : Text('');
  }

  String _formatTime(Timestamp time) {
    DateTime date = time.toDate();
    return '${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}';
  }

  CameraPosition _cameraPosition(double latitude, double longitude) {
    return CameraPosition(target: LatLng(latitude, longitude), zoom: 16);
  }

  Future<Venue> _getVenue() {
    return getVenue(_venueMap['venueId']);
  }

  Future<Concert> _getConcert() {
    return getConcert(_venueMap['concertId']);
  }
}
