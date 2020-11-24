import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//varibles for favorite
final String favorites = 'favorites';
final String columnArtistId = 'artistId';
final String columnIsFavorite = 'isFavorite';

//variables for bookmark
final String bookmarks = 'bookmarks';
final String columnBookmarkId = 'bookmarkId';
final String columnIsBookmarked = 'isBookmarked';

class Bookmark {
  String bookmarkId;
  bool isBookmarked;

  Bookmark(this.bookmarkId, this.isBookmarked);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'isBookmarked': isBookmarked == true ? 1 : 0,
    };
    if (bookmarkId != null) {
      map['bookmarkId'] = bookmarkId;
    }
    return map;
  }

  Bookmark.fromMap(Map<String, dynamic> data) {
    bookmarkId = data['bookmarkId'];
    isBookmarked = data['isBookmarked'] == 1;
  }
}

class Favorite {
  String artistId;
  bool isFavorite;

  Favorite(this.artistId, this.isFavorite);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'isFavorite': isFavorite == true ? 1 : 0,
    };
    if (artistId != null) {
      map['artistId'] = artistId;
    }
    return map;
  }

  Favorite.fromMap(Map<String, dynamic> data) {
    artistId = data['artistId'];
    isFavorite = data['isFavorite'] == 1;
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
      $columnIsFavorite INTEGER NOT NULL
      )
      ''');
    await db.execute('''
      CREATE TABLE $bookmarks (
      $columnBookmarkId TEXT PRIMARY KEY NOT NULL,
      $columnIsBookmarked INTEGER NOT NULL
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
        columns: [columnBookmarkId, columnIsBookmarked],
        where: '$columnBookmarkId = ?',
        whereArgs: [bookmarkId]);
    if (maps.length > 0) {
      return Bookmark.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getBookmarks() async {
    Database db = await database;
    return await db.query(bookmarks);
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
        columns: [columnArtistId, columnIsFavorite],
        where: '$columnArtistId = ?',
        whereArgs: [artistId]);
    if (maps.length > 0) {
      return Favorite.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    Database db = await database;
    return await db.query(favorites);
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
