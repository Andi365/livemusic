import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Venue {
  String venueId;
  String name;
  var spectators;
  GeoPoint coordinates;

  Venue.fromMap(String id, Map<String, dynamic> data) {
    venueId = id;
    name = data['name'];
    spectators = data['spectators'];
    coordinates = data['coordinates'];
  }

  Map<String, dynamic> toMap() {
    return {
      'venueId': venueId,
      'name': name,
      'spectators': spectators,
      'coordinates': coordinates,
    };
  }
}
