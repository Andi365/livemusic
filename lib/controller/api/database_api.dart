import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livemusic/model/Artist.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//varibles for favorite
final String favorites = 'favorites';
final String columnArtistId = 'artistId';
final String columnArtistName = 'artistName';
final String columnIsFavorite = 'isFavorite';
final String columnFavoriteImageURL = 'FavoriteImageURL';

class Favorite {
  String artistId;
  bool isFavorite;
  String imageUrl;
  String artistName;

  Favorite(this.artistId, this.isFavorite, this.imageUrl, this.artistName);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnIsFavorite: isFavorite == true ? 1 : 0,
      columnFavoriteImageURL: imageUrl,
      columnArtistName: artistName
    };
    if (artistId != null) {
      map[columnArtistId] = artistId;
    }
    return map;
  }

  Favorite.fromMap(Map<String, dynamic> data) {
    artistId = data[columnArtistId];
    isFavorite = data[columnIsFavorite] == 1;
    imageUrl = data[columnFavoriteImageURL];
    artistName = data[columnArtistName];
  }
}

//variables for bookmark
final String bookmarks = 'bookmarks';
final String columnBookmarkId = 'bookmarkId';
final String columnIsBookmarked = 'isBookmarked';
final String columnTimestamp = 'timestamp';
final String columnVenueName = 'venueName';
final String columnArtistImageURL = 'ArtistImageURL';
final String columnVenueId = 'venueId';

class Bookmark {
  String bookmarkId;
  bool isBookmarked;
  int timestamp;
  String venueName;
  String imageUrl;
  String venueId;

  Bookmark(this.bookmarkId, this.venueName, this.imageUrl, this.venueId,
      {this.isBookmarked = false, this.timestamp});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnIsBookmarked: isBookmarked == true ? 1 : 0,
      columnVenueName: venueName,
      columnArtistImageURL: imageUrl,
      columnVenueId: venueId,
    };
    if (bookmarkId != null) {
      map[columnBookmarkId] = bookmarkId;
    }
    if (timestamp == null) {
      map[columnTimestamp] = Timestamp.now().seconds;
    }
    return map;
  }

  Bookmark.fromMap(Map<String, dynamic> data) {
    bookmarkId = data[columnBookmarkId];
    isBookmarked = data[columnIsBookmarked] == 1;
    timestamp = data[columnTimestamp];
    venueName = data[columnVenueName];
    imageUrl = data[columnArtistImageURL];
    venueId = data[columnVenueId];
  }
}

class DatabaseAPI {
  static final _databaseName = 'database.db';
  static final _databaseVersion = 1;

  DatabaseAPI._privateConstructor();
  static final DatabaseAPI instance = DatabaseAPI._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $favorites (
      $columnArtistId TEXT PRIMARY KEY NOT NULL,
      $columnIsFavorite INTEGER NOT NULL,
      $columnFavoriteImageURL TEXT NOT NULL,
      $columnArtistName TEXT NOT NULL
      )
      ''');
    await db.execute('''
      CREATE TABLE $bookmarks (
      $columnBookmarkId TEXT PRIMARY KEY NOT NULL,
      $columnIsBookmarked INTEGER NOT NULL,
      $columnTimestamp INTEGER NOT NULL,
      $columnVenueName TEXT NOT NULL,
      $columnArtistImageURL TEXT NOT NULL,
      $columnVenueId TEXT NOT NULL
      )
      ''');
  }

  // Bookmarks helper methods:
  Future<int> insertBookmark(Bookmark bookmark) async {
    Database db = await database;
    print(bookmark.toMap());
    int bookmarkId = await db.insert(bookmarks, bookmark.toMap());
    return bookmarkId;
  }

  Future<Bookmark> getBookmark(String bookmarkId) async {
    Database db = await database;
    List<Map> maps = await db.query(bookmarks,
        columns: [
          columnBookmarkId,
          columnIsBookmarked,
          columnTimestamp,
          columnVenueName,
          columnArtistImageURL,
          columnVenueId
        ],
        where: '$columnBookmarkId = ?',
        whereArgs: [bookmarkId]);
    if (maps.length > 0) {
      return Bookmark.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Bookmark>> getBookmarks() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(bookmarks);

    return List.generate(maps.length, (i) {
      return Bookmark.fromMap(maps[i]);
    });
  }

  Future<List<Map<String, dynamic>>> getVenueNameB(String bookmarkId) async {
    Database db = await database;
    List<Map<String, dynamic>> artistN = await db.query(bookmarks,
        columns: [columnVenueName],
        where: '$columnBookmarkId = ?',
        whereArgs: [bookmarkId]);
    return artistN;
  }

  Future<int> deleteBookmark(String bookmarkId) async {
    Database db = await database;
    return await db.delete(bookmarks,
        where: '$columnBookmarkId = ?', whereArgs: [bookmarkId]);
  }

  Future<int> updateBookmark(Bookmark bookmark) async {
    Database db = await database;
    return await db.update(bookmarks, bookmark.toMap(),
        where: '$columnBookmarkId = ?', whereArgs: [bookmark.bookmarkId]);
  }

  // favorite helper methods:
  Future<int> insertFavorite(Favorite favorite) async {
    Database db = await database;
    print(favorite.toMap());
    int artistId = await db.insert(favorites, favorite.toMap());
    return artistId;
  }

  Future<Favorite> getFavorite(String artistId) async {
    Database db = await database;
    List<Map> maps = await db.query(favorites,
        columns: [
          columnArtistId,
          columnIsFavorite,
          columnFavoriteImageURL,
          columnArtistName
        ],
        where: '$columnArtistId = ?',
        whereArgs: [artistId]);
    if (maps.length > 0) {
      return Favorite.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Favorite>> getFavorites() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(favorites);

    return List.generate(maps.length, (index) {
      return Favorite.fromMap(maps[index]);
    });
  }

  Future<int> deleteFavorite(String artistId) async {
    Database db = await database;
    return await db
        .delete(favorites, where: '$columnArtistId = ?', whereArgs: [artistId]);
  }

  Future<int> updateFavorite(Favorite favorite) async {
    Database db = await database;
    return await db.update(favorites, favorite.toMap(),
        where: '$columnArtistId = ?', whereArgs: [favorite.artistId]);
  }
}
