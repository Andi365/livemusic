class Artist {
  String id;
  String image;
  String name;
  bool isBand;
  String genre;
  var rating;
  var noOfRatings;
  String bio;
  List members;

  Artist.fromMap(String id, Map<String, dynamic> data) {
    this.id = id;
    image = data['image'];
    name = data['name'];
    isBand = data['isBand'];
    genre = data['genre'];
    rating = data['rating'];
    noOfRatings = data['noOfRatings'];
    bio = data['bio'];
    members = data['members'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'isBand': isBand,
      'genre': genre,
      'rating': rating,
      'noOfRatings': noOfRatings,
      'bio': bio,
      'members': members
    };
  }
}
