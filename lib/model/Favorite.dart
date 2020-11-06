class Favorite {
  int id;
  String artistId;
  bool isFavorite = false;

  Favorite();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'artistId': artistId,
      'isFavorite': isFavorite == true ? 1 : 0,
    };
  }

  Favorite.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    artistId = data['artistId'];
    isFavorite = data['isFavorite'];
  }

}