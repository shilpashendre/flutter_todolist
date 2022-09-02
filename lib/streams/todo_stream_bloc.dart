import 'dart:async';

import 'package:todolist/db/todolist_database.dart';
import 'package:todolist/model/todolist_model.dart';

class TodoStreamBloc {
  static final StreamController<List<TodoList>> todoListStreamController =
      StreamController<List<TodoList>>.broadcast();

  static final StreamController<bool> addOrUpdateStreamController =
      StreamController<bool>.broadcast();

  static void fetchTodoList() async {
    List<TodoList> todoList = await ToDoListDatabase.instance.getToDoList();
    todoListStreamController.add(todoList);
  }

  static void addTodo(String title, String description, String sectionName) async {
    final todoList = TodoList(
      description: description,
      sections: sectionName,
      title: title,
    );
    try {
      await ToDoListDatabase.instance.create(todoList);
      addOrUpdateStreamController.add(true);
    } catch (e) {
      addOrUpdateStreamController.addError(e);
    }
  }

  static void updateTodo(int id, String title, String description, String sectionName) async {
    final todoList = TodoList(
      id: id,
      description: description,
      sections: sectionName,
      title: title,
    );
    try {
      await ToDoListDatabase.instance.update(todoList);
      addOrUpdateStreamController.add(true);
    } catch (e) {
      addOrUpdateStreamController.addError(e);
    }
  }

  static void deleteTodo(int id) {
    ToDoListDatabase.instance.delete(id);
  }
}
