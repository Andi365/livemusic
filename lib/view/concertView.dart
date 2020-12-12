import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:livemusic/api/artist_api.dart';
import 'package:livemusic/colors.dart';
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

  @override
  void initState() {
    super.initState();
    _venueMap = widget.map;
    _venueFuture = _getVenue();
  }

  CameraPosition _cameraPosition(double latitude, double longitude) {
    return CameraPosition(target: LatLng(latitude, longitude), zoom: 16);
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
                    child: Column(children: [
                  Container(
                    height: 300,
                    child: GoogleMap(
                      mapType: MapType.hybrid,
                      initialCameraPosition: _cameraPosition(
                          snapshot.data.coordinates.latitude,
                          snapshot.data.coordinates.longitude),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  )
                ])));
            break;
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            return Text('');
        }
      },
    );
  }

  Future<Venue> _getVenue() {
    return getVenue(_venueMap['venueName']);
  }
}
