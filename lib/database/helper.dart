import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('records.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, fileName);
    // ignore: await_only_futures
    var database = await sqlite3.open(path);
    await createTables(database);
    return database;
  }

  Future<void> createTables(Database db) async {
    db.execute('''
      CREATE TABLE IF NOT EXISTS records (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        date_arrival TEXT NOT NULL,
        body_temperature REAL NOT NULL,
        condition TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertRecord(Map<String, dynamic> record) async {
    final db = await database;
    db.execute('''
      INSERT INTO records (name, date_arrival, body_temperature, condition) VALUES (?, ?, ?, ?)
    ''', [record['name'], record['date_arrival'], record['body_temperature'], record['condition']]);
    final id = db.select('SELECT last_insert_rowid()').first['last_insert_rowid()'];
    return id;
  }

  Future<List<Map<String, dynamic>>> getRecords() async {
    final db = await database;
    final result = db.select('SELECT * FROM records');
    return result.map((row) => {
      'id': row['id'],
      'name': row['name'],
      'date_arrival': row['date_arrival'],
      'body_temperature': row['body_temperature'],
      'condition': row['condition']
    }).toList();
  }

  Future<void> updateRecord(Map<String, dynamic> record) async {
    final db = await database;
    db.execute('''
      UPDATE records SET name = ?, date_arrival = ?, body_temperature = ?, condition = ? WHERE id = ?
    ''', [record['name'], record['date_arrival'], record['body_temperature'], record['condition'], record['id']]);
  }

  Future<void> deleteRecord(int id) async {
    final db = await database;
    db.execute('DELETE FROM records WHERE id = ?', [id]);
  }

  Future<Map<String, dynamic>> getChildData(int childId) async {
    final db = await database;
    final List<Map<String, dynamic>> results = db.select(
      'SELECT * FROM records WHERE id = ?',
      [childId],
    );
    if (results.isNotEmpty) {
      return results.first;
    } else {
      throw Exception('Data anak tidak ditemukan From Helper');
    }
  }
}
