
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../Model/Db_Model.dart';
enum TableName { table1, table2 }
class DBHelper {
  static Database? _db,_db2;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'History1.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }
 initDatabase2() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'History2.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate2,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE History1 (id INTEGER PRIMARY KEY , title VARCHAR,tab INTEGER)');
  }
  _onCreate2(Database db, int version) async {
    await db.execute(
        'CREATE TABLE History2 (id INTEGER PRIMARY KEY , title VARCHAR,tab INTEGER)');
  }

  Future<DB_Model> insert(TableName tableName, DB_Model dbModel) async {
    var dbClient = await db;
    List<Map<String, Object?>> existingRecords = await dbClient!.query(
      _tableNameToString(tableName),
      where: 'title = ?',
      whereArgs: [dbModel.title],
    );

    if (existingRecords.isEmpty) {
      await dbClient.insert(_tableNameToString(tableName), dbModel.toMap());
    } else {
      print('Record with title ${dbModel.title} already exists.');
    }
    return dbModel;
  }

  Future<List<String>> getTitlesList(TableName tableName) async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query(_tableNameToString(tableName));
    return queryResult.map((e) => e['title'] as String).toList();
  }

  String _tableNameToString(TableName tableName) {
    switch (tableName) {
      case TableName.table1:
        return 'History1';
      case TableName.table2:
        return 'History2';
    }
  }
}
