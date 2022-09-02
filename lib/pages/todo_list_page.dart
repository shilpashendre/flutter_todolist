import 'package:flutter/material.dart';
import 'package:todolist/db/todolist_database.dart';
import 'package:todolist/enums/sections_type.dart';
import 'package:todolist/model/todolist_modal.dart';
import 'package:todolist/enums/action_type.dart';
import 'package:todolist/pages/add_task_page.dart';
import 'package:todolist/pages/sections_widget.dart';
import 'package:todolist/widget/card_widget.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  late List<TodoList> todoList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshList();
  }

  @override
  void dispose() {
    ToDoListDatabase.instance.close();
    super.dispose();
  }

  void refreshList() async {
    setState(() {
      isLoading = true;
    });
    this.todoList = await ToDoListDatabase.instance.getToDoList();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SectionsWidget(
                title: SectionsType.TODAY.name,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddTaskPage(
                                actionType: ActionType.ADD,
                                sectionsType: SectionsType.TODAY,
                              ))).then((value) => refreshList());
                },
              ),
              CardWidget(
                sectionType: SectionsType.TODAY,
                todoList: todoList.isNotEmpty
                    ? todoList
                        .where((element) =>
                            element.sections == SectionsType.TODAY.name)
                        .toList()
                    : [],
                refresh: () => refreshList(),
              ),
              SectionsWidget(
                  title: SectionsType.TOMORROW.name,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddTaskPage(
                                  actionType: ActionType.ADD,
                                  sectionsType: SectionsType.TOMORROW,
                                ))).then((value) => refreshList());
                  }),
              CardWidget(
                sectionType: SectionsType.TOMORROW,
                todoList: todoList.isNotEmpty
                    ? todoList
                        .where((element) =>
                            element.sections == SectionsType.TOMORROW.name)
                        .toList()
                    : [],
                refresh: () => refreshList(),
              ),
              SectionsWidget(
                  title: SectionsType.UPCOMMING.name,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddTaskPage(
                                  actionType: ActionType.ADD,
                                  sectionsType: SectionsType.UPCOMMING,
                                ))).then((value) => refreshList());
                  }),
              CardWidget(
                sectionType: SectionsType.UPCOMMING,
                todoList: todoList.isNotEmpty
                    ? todoList
                        .where((element) =>
                            element.sections == SectionsType.UPCOMMING.name)
                        .toList()
                    : [],
                refresh: () => refreshList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
