

import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

class ActivityDatabaseHelper {
  static final ActivityDatabaseHelper instance = ActivityDatabaseHelper._init();

  static Database? _database;

  ActivityDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('activities.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, fileName);
    var database = sqlite3.open(path);
    await createTables(database);
    return database;
  }

  Future<void> createTables(Database db) async {
    db.execute('''
      CREATE TABLE IF NOT EXISTS activities (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        meals TEXT,
        toilets TEXT,
        rests TEXT,
        bottles TEXT,
        shower TEXT,
        vitamin TEXT,
        notesForParents TEXT,
        itemsNeeded TEXT
      )
    ''');
  }

  Future<int> insertActivity(Map<String, dynamic> activity) async {
    final db = await database;
    db.execute('''
      INSERT INTO activities (meals, toilets, rests, bottles, shower, vitamin, notesForParents, itemsNeeded) 
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    ''', [
      jsonEncode(activity['meals']),
      jsonEncode(activity['toilets']),
      jsonEncode(activity['rests']),
      jsonEncode(activity['bottles']),
      activity['shower'] ?? '',
      activity['vitamin'] ?? '',
      activity['notesForParents'] ?? '',
      jsonEncode(activity['itemsNeeded'])
    ]);
    final id = db.select('SELECT last_insert_rowid()').first['last_insert_rowid()'];
    return id;
  }

  Future<List<Map<String, dynamic>>> getActivities() async {
    final db = await database;
    final result = db.select('SELECT * FROM activities');
    return result.map((row) => {
      'id': row['id'],
      'meals': row['meals'] != null ? jsonDecode(row['meals']) : [],
      'toilets': row['toilets'] != null ? jsonDecode(row['toilets']) : [],
      'rests': row['rests'] != null ? jsonDecode(row['rests']) : [],
      'bottles': row['bottles'] != null ? jsonDecode(row['bottles']) : [],
      'shower': row['shower'] ?? '',
      'vitamin': row['vitamin'] ?? '',
      'notesForParents': row['notesForParents'] ?? '',
      'itemsNeeded': row['itemsNeeded'] != null ? jsonDecode(row['itemsNeeded']) : []
    }).toList();
  }


  Future<void> updateActivity(Map<String, dynamic> activity) async {
    final db = await database;
    db.execute('''
      UPDATE activities SET meals = ?, toilets = ?, rests = ?, bottles = ?, shower = ?, vitamin = ?, notesForParents = ?, itemsNeeded = ? 
      WHERE id = ?
    ''', [
      jsonEncode(activity['meals']),
      jsonEncode(activity['toilets']),
      jsonEncode(activity['rests']),
      jsonEncode(activity['bottles']),
      activity['shower'],
      activity['vitamin'],
      activity['notesForParents'],
      jsonEncode(activity['itemsNeeded']),
      activity['id']
    ]);
  }

  Future<void> deleteActivity(int id) async {
    final db = await database;
    db.execute('DELETE FROM activities WHERE id = ?', [id]);
  }

  Future<void> deleteAllActivities() async {
    final db = await database;
    db.execute('DELETE FROM activities');
  }

  Future<Map<String, dynamic>> getActivity(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> results = db.select(
      'SELECT * FROM activities WHERE id = ?',
      [id],
    );
    if (results.isNotEmpty) {
      var row = results.first;
      return {
        'id': row['id'],
        'meals': row['meals'] != null ? jsonDecode(row['meals']) : null,
        'toilets': row['toilets'] != null ? jsonDecode(row['toilets']) : null,
        'rests': row['rests'] != null ? jsonDecode(row['rests']) : null,
        'bottles': row['bottles'] != null ? jsonDecode(row['bottles']) : null,
        'shower': row['shower'],
        'vitamin': row['vitamin'],
        'notesForParents': row['notesForParents'],
        'itemsNeeded': row['itemsNeeded'] != null ? jsonDecode(row['itemsNeeded']) : null
      };
    } else {
      throw Exception('Activity not found');
    }
  }
}
