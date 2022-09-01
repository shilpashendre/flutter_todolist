import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:todolist/model/todolist_modal.dart';
import 'package:path/path.dart';

class ToDoListDatabase {
  static final ToDoListDatabase instance = ToDoListDatabase._init();
  static Database? _database;
  ToDoListDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('todolist.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''CREATE TABLE $tableTodolist (
  ${TodolistFileds.id} $idType,
  ${TodolistFileds.title} $textType,
  ${TodolistFileds.description} $textType,
  ${TodolistFileds.sections} $textType
)''');
  }

  Future<TodoList> create(TodoList list) async {
    final db = await instance.database;
    final id = await db.insert(tableTodolist, list.toJson());

    return list.copy(id: id);
  }

  Future getToDoList() async {
    final db = await instance.database;
    final orderBy = '${TodolistFileds.id} ASC';

    final result = await db.query(tableTodolist, orderBy: orderBy);
    return result.map((e) => TodoList.formJson(e)).toList();
  }

  Future getItemByID(int id) async {
    final db = await instance.database;
    final maps = await db.query(tableTodolist,
        columns: TodolistFileds.values,
        where: '${TodolistFileds.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return TodoList.formJson(maps.first);
    } else {
      throw Exception("ID $id not found");
    }
  }

  Future<int> update(TodoList list) async {
    final db = await instance.database;
    return db.update(tableTodolist, list.toJson(),
        where: '${TodolistFileds.id} = ?', whereArgs: [list.id]);
  }

  Future<int> delete(TodoList list) async {
    final db = await instance.database;
    return db.delete(tableTodolist,
        where: '${TodolistFileds.id} = ?', whereArgs: [list.id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
