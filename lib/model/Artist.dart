import 'package:cloud_firestore/cloud_firestore.dart';

class Artist {
  String id;
  String image;
  String name;
  bool isBand;
  var rating;
  String bio;
  List members;

  Artist.fromMap(String id1, Map<String, dynamic> data) {
    id = id1;
    image = data['image'];
    name = data['name'];
    isBand = data['isBand'];
    rating = data['rating'];
    bio = data['bio'];
    members = data['members'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'isBand': isBand,
      'rating': rating,
      'bio': bio,
      'members': members
    };
  }
}
