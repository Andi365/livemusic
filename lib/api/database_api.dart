import 'dart:io';

import 'package:livemusic/model/Favorite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseAPI {
  static final _databaseName = 'favorites.db';
  static final _databaseVersion = 1;

  final String favorites = 'favorites';
  final String columnId = '_id';
  final String columnArtistId = 'artistId';
  final String columnIsFavorite = 'isFavorite';


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
      version: _databaseVersion,
      onCreate: _onCreate);
      }

  // SQL string to create the database 
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $favorites (
      $columnId INTEGER PRIMARY KEY,
      $columnArtistId TEXT NOT NULL,
      $columnIsFavorite INTEGER NOT NULL
      )
      ''');
  }

  // Database helper methods:
  Future<int> insert(Favorite favorite) async {
    Database db = await database;
    int id = await db.insert(favorites, favorite.toMap());
    return id;
  }

  Future<Favorite> queryWord(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(favorites,
      columns: [columnId, columnArtistId, columnIsFavorite],
        where: '$columnId = ?',
        whereArgs: [id]);
      if (maps.length > 0) {
        return Favorite.fromMap(maps.first);
      }
      return null;
  }
}