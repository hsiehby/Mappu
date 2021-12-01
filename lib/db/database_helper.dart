import 'package:http/http.dart';
import 'package:mappu/models/postcard.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mappu/models/saved_article.dart';
import 'package:mappu/models/read_article.dart';
import 'package:mappu/models/explored_country.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('mappu.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 6, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {


    await db.execute(
      'DROP TABLE IF EXISTS postcards',
    );

    await db.execute(
      'DROP TABLE IF EXISTS readArticles',
    );

    await db.execute(
      'DROP TABLE IF EXISTS exploredCountries',
    );

    await db.execute(
      'CREATE TABLE postcards('
          'postcardId TEXT PRIMARY KEY,'
          'name TEXT,'
          'description TEXT,'
          'iconPath TEXT,'
          'earned INTEGER,'
          'earnedAt TEXT,'
          'minCountries INTEGER,'
          'minArticles INTEGER)',
    );

    await db.execute(
      'CREATE TABLE savedArticles('
          'articleId TEXT PRIMARY KEY,'
          'title TEXT,'
          'link TEXT,'
          'pubDate TEXT,'
          'source TEXT,'
          'sourceURL TEXT,'
          'countryId TEXT,'
          'savedAt TEXT)',
    );

    // TODO fix create table error
    await db.execute(
      'CREATE TABLE readArticles('
          'articleId TEXT PRIMARY KEY,'
          'readAt TEXT)',
    );

    await db.execute(
      'CREATE TABLE exploredCountries('
          'countryId TEXT PRIMARY KEY,'
          'exploredAt TEXT)',
    );

    await initializePostcards(db);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  // Methods for Postcard
  // Populate the postcards database with pre-defined postcards
  Future<void> initializePostcards(Database db) async {
    List<Postcard> _postcards = [];

    final String response = await rootBundle.loadString('assets/postcards/postcards.json');
    final data = await jsonDecode(response);
    _postcards = data.map<Postcard>((item) => (Postcard.fromJson(item))).toList();

    for (final Postcard postcard in _postcards) {
      await db.insert(
        'postcards',
        postcard.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> insertPostcard(Postcard postcard) async {
    final db = await instance.database;

    await db.insert(
      'postcards',
      postcard.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> getPostcardsCount() async {
    final db = await instance.database;

    var count = Sqflite
        .firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM postcards'));
    return count?? 0;
  }

  Future<List<Postcard>> getPostcards() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query('postcards');
    return List.generate(maps.length, (i) {
      return Postcard(
        postcardId: maps[i]['postcardId'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        iconPath: maps[i]['iconPath'],
        earned: maps[i]['earned'] == 0 ? false : true,
        earnedAt: maps[i]['earnedAt'] != null ? DateTime.parse(maps[i]['earnedAt']) : null,
        minCountries: maps[i]['minCountries'],
        minArticles: maps[i]['minArticles'],
      );
    });
  }

  Future<void> updatePostcard(Postcard postcard) async {
    final db = await instance.database;

    await db.update(
      'postcards',
      postcard.toMap(),
      where: 'postcardId = ?',
      whereArgs: [postcard.postcardId],
    );
  }

  Future<void> deletePostcard(String postcardId) async {
    final db = await instance.database;

    await db.delete(
      'postcards',
      where: 'postcardId = ?',
      whereArgs: [postcardId],
    );
  }

  // Method for unlocking postcards
  Future<void> checkPostcardStatus() async {
    int numArticlesRead = await getReadArticlesCount();
    int numCountriesExplored = await getExploredCountriesCount();

    List<Postcard> postcards = await getPostcards();
    for (Postcard postcard in postcards) {
      if (!postcard.earned
          && numArticlesRead >= postcard.minArticles
          && numCountriesExplored >= postcard.minCountries) {
        print('Unlocked postcard id: ${postcard.postcardId}');
        postcard.earned = true;
        postcard.earnedAt = DateTime.now();
        updatePostcard(postcard);
      }
    }
  }

  // Methods for SavedArticle
  Future<void> insertSavedArticle(SavedArticle savedArticle) async {
    final db = await instance.database;

    await db.insert(
      'savedArticles',
      savedArticle.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SavedArticle>> getSavedArticles() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query('savedArticles', orderBy: 'savedAt DESC');

    return List.generate(maps.length, (i) {
      return SavedArticle(
        articleId: maps[i]['articleId'],
        title: maps[i]['title'],
        link: maps[i]['link'],
        pubDate: DateTime.parse(maps[i]['pubDate']),
        source: maps[i]['source'],
        sourceURL: maps[i]['sourceURL'],
        countryId: maps[i]['countryId'],
        savedAt: DateTime.parse(maps[i]['savedAt']),
      );
    });
  }

  Future<void> updateSavedArticle(SavedArticle savedArticle) async {
    final db = await instance.database;

    await db.update(
      'savedArticles',
      savedArticle.toMap(),
      where: 'articleId = ?',
      whereArgs: [savedArticle.articleId],
    );
  }

  Future<void> deleteSavedArticle(String articleId) async {
    final db = await instance.database;

    await db.delete(
      'savedArticles',
      where: 'articleId = ?',
      whereArgs: [articleId],
    );
  }

  // Methods for ReadArticle
  Future<void> insertReadArticle(ReadArticle readArticle) async {
    final db = await instance.database;

    await db.insert(
      'readArticles',
      readArticle.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );

    checkPostcardStatus();
  }

  Future<List<ReadArticle>> getReadArticles() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query('readArticles');

    return List.generate(maps.length, (i) {
      return ReadArticle(
        articleId: maps[i]['articleId'],
        readAt: DateTime.parse(maps[i]['readAt']),
      );
    });
  }

  Future<int> getReadArticlesCount() async {
    final db = await instance.database;

    var count = Sqflite
        .firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM readArticles'));
    return count?? 0;
  }

  Future<void> updateReadArticle(ReadArticle readArticle) async {
    final db = await instance.database;

    await db.update(
      'readArticles',
      readArticle.toMap(),
      where: 'articleId = ?',
      whereArgs: [readArticle.articleId],
    );
  }

  Future<void> deleteReadArticle(String articleId) async {
    final db = await instance.database;

    await db.delete(
      'readArticles',
      where: 'articleId = ?',
      whereArgs: [articleId],
    );
  }

  // Methods for ExploredCountry
  Future<void> insertExploredCountry(ExploredCountry exploredCountry) async {
    final db = await instance.database;

    await db.insert(
      'exploredCountries',
      exploredCountry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );

    checkPostcardStatus();
  }

  Future<List<ExploredCountry>> getExploredCountries() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query('exploredCountries');

    return List.generate(maps.length, (i) {
      return ExploredCountry(
        countryId: maps[i]['countryId'],
        exploredAt: DateTime.parse(maps[i]['exploredAt']),
      );
    });
  }

  Future<int> getExploredCountriesCount() async {
    final db = await instance.database;

    var count = Sqflite
        .firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM exploredCountries'));
    return count?? 0;
  }

  Future<void> updateExploredCountry(ExploredCountry exploredCountry) async {
    final db = await instance.database;

    await db.update(
      'exploredCountries',
      exploredCountry.toMap(),
      where: 'countryId = ?',
      whereArgs: [exploredCountry.countryId],
    );
  }

  Future<void> deleteExploredCountry(String countryId) async {
    final db = await instance.database;

    await db.delete(
      'exploredCountries',
      where: 'countryId = ?',
      whereArgs: [countryId],
    );
  }

  Future<void> resetProgress() async {
    final db = await instance.database;

    await db.delete('readArticles');
    await db.delete('savedArticles');
    await db.delete('exploredCountries');
  }
}