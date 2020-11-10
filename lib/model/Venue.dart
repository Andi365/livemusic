class Venue {
  String name;
  var spectators;

  Venue.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    spectators = data['spectators'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'spectators': spectators,
    };
  }
}
