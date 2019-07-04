import 'dart:io';

import 'package:flutter_clean_architecture/data/local/db/db_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabaseHelper extends DatabaseHelper{
  final String databaseName;
  static Database _database;
  static final _databaseVersion = 1;
  static final table = 'my_table';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnAge = 'age';

  AppDatabaseHelper(this.databaseName);

  @override
  String getDatabaseName() {
    return databaseName;
  }

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnAge INTEGER NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert(table, row);
  }
}