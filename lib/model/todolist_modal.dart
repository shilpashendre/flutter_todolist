final String tableTodolist = "todolist"; //table name

// column name of data table
class TodolistFileds {
  static final List<String> values = [id, title, description, sections];
  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String sections = 'sections';
}

class TodoList {
  final int? id;
  final String title;
  final String description;
  final String sections;

  TodoList(
      {required this.description,
      this.id,
      required this.sections,
      required this.title});

  Map<String, Object?> toJson() => {
        TodolistFileds.id: id,
        TodolistFileds.title: title,
        TodolistFileds.description: description,
        TodolistFileds.sections: sections,
      };

  static TodoList formJson(Map<String, Object?> json) => TodoList(
      id: json[TodolistFileds.id] as int?,
      title: json[TodolistFileds.title] as String,
      description: json[TodolistFileds.description] as String,
      sections: json[TodolistFileds.sections] as String);

  TodoList copy(
          {int? id, String? title, String? description, String? sections}) =>
      TodoList(
          description: description ?? this.description,
          id: id ?? this.id,
          sections: sections ?? this.sections,
          title: title ?? this.title);
}
