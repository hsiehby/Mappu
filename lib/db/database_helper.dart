import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mappu/models/saved_article.dart';
import 'package:mappu/models/read_article.dart';
import 'package:mappu/models/explored_country.dart';

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

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
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
    // await db.execute(
    //   'CREATE TABLE readArticles('
    //       'articleId TEXT PRIMARY KEY'
    //       'readAt TEXT)',
    // );
    //
    // await db.execute(
    //   'CREATE TABLE exploredCountries('
    //       'countryId TEXT PRIMARY KEY'
    //       'exploredAt TEXT)',
    // );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
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
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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
}