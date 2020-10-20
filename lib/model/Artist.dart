import 'package:cloud_firestore/cloud_firestore.dart';

class Artist {
  String id;
  String image;
  String name;
  bool isBand;
  var rating;
  String bio;
  List members;

  Artist.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    image = data['image'];
    name = data['name'];
    isBand = data['isBand'];
    rating = data['rating'];
    bio = data['bio'];
    members = data['members'];
  }
}
