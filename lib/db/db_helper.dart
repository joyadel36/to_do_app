import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do/models/task.dart';

class DBHelper {
  static Database? _db;
  static final String _tablename = 'tasks';
  static final int _version = 1;

  static Future<void> initdb() async {
    if (_db != null) {
      debugPrint(" not null data base ");
      return;
    } else
      try {
        String _path = await getDatabasesPath() + 'tasks.db';
        debugPrint(" in data base ");
     _db = await openDatabase(_path, version: _version,
            onCreate: (Database db, int version) async {
          // When creating the db, create the table
          return db.execute(
              'CREATE TABLE $_tablename (id INTEGER PRIMARY KEY AUTOINCREMENT,'
              'title STRING,note TEXT,'
              'isCompleted INTEGER, date STRING,'
              'startTime STRING,endTime STRING,'
              'color INTEGER,remind INTEGER, repeat STRING)');
        });
        print("\nDatabase created");
      } catch (e) {
        print(e);
      }
  }

  static Future<int> insert(Task task) async {
    print("\n insert func");
    return await _db!.insert(_tablename, task.toJson());
  }

  static Future<int> delete(Task task) async {
    print("\n delete func");
    return await _db!.delete(_tablename, where: 'id = ?', whereArgs: [task.id]);
  }
  static Future<int> deleteall() async {
    print("\n delete all func");
    return await _db!.delete(_tablename);
  }

  static Future<int> update(int id) async {
    print("\n update func");
    return await _db!.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WHERE id = ?
    ''', [1, id]);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("\n query func");
    return await _db!.query(_tablename);
  }
}
