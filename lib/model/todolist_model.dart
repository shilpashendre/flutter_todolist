import 'dart:convert';

class TodoListFields {
  static final List<String> values = [id, title, description, sections];
  static const String tableTodolist = "todolist";
  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String sections = 'sections';
}

class TodoList {
  TodoList({
    this.id,
    required this.title,
    required this.description,
    required this.sections,
  });

  final int? id;
  final String title;
  final String description;
  final String sections;

  TodoList copyWith({
    int? id,
    String? title,
    String? description,
    String? sections,
  }) =>
      TodoList(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        sections: sections ?? this.sections,
      );

  factory TodoList.fromJson(String str) => TodoList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TodoList.fromMap(Map<String, dynamic> json) => TodoList(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        sections: json["sections"],
      );

  Map<String, dynamic> toMap() => {
        if (id != null) "_id": id,
        "title": title,
        "description": description,
        "sections": sections,
      };
}
