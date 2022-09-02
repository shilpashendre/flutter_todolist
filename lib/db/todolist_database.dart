import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:todolist/model/todolist_model.dart';
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

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''CREATE TABLE ${TodoListFields.tableTodolist} (
  ${TodoListFields.id} $idType,
  ${TodoListFields.title} $textType,
  ${TodoListFields.description} $textType,
  ${TodoListFields.sections} $textType
)''');
  }

  Future<TodoList> create(TodoList list) async {
    final db = await instance.database;

    final id = await db.insert(TodoListFields.tableTodolist, list.toMap());

    return list.copyWith(id: id);
  }

  Future<List<TodoList>> getToDoList() async {
    final db = await instance.database;
    const orderBy = '${TodoListFields.id} ASC';

    final result = await db.query(TodoListFields.tableTodolist, orderBy: orderBy);

    return result.map((e) => TodoList.fromMap(e)).toList();
  }

  Future<TodoList> getItemByID(int id) async {
    final db = await instance.database;
    final maps = await db.query(TodoListFields.tableTodolist,
        columns: TodoListFields.values, where: '${TodoListFields.id} = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return TodoList.fromMap(maps.first);
    } else {
      throw Exception("ID $id not found");
    }
  }

  Future<int> update(TodoList list) async {
    final db = await instance.database;
    return db.update(TodoListFields.tableTodolist, list.toMap(),
        where: '${TodoListFields.id} = ?', whereArgs: [list.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db
        .delete(TodoListFields.tableTodolist, where: '${TodoListFields.id} = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
