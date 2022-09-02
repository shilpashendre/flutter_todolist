import 'package:flutter/material.dart';
import 'package:todolist/enums/sections_type.dart';
import 'package:todolist/model/todolist_model.dart';
import 'package:todolist/enums/action_type.dart';
import 'package:todolist/pages/add_task_page.dart';
import 'package:todolist/pages/sections_widget.dart';
import 'package:todolist/streams/todo_stream_bloc.dart';
import 'package:todolist/widget/card_widget.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    TodoStreamBloc.fetchTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: StreamBuilder<List<TodoList>>(
            stream: TodoStreamBloc.todoListStreamController.stream,
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.active
                  ? Column(
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
                                        ))).then(
                              (value) => TodoStreamBloc.fetchTodoList(),
                            );
                          },
                        ),
                        SizedBox(
                          height: 250,
                          child: CardWidget(
                            sectionType: SectionsType.TODAY,
                            todoList: snapshot.data!.isNotEmpty
                                ? snapshot.data!
                                    .where((element) => element.sections == SectionsType.TODAY.name)
                                    .toList()
                                : [],
                            postAction: () => TodoStreamBloc.fetchTodoList(),
                          ),
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
                                          ))).then(
                                (value) => TodoStreamBloc.fetchTodoList(),
                              );
                            }),
                        SizedBox(
                          height: 250,
                          child: CardWidget(
                            sectionType: SectionsType.TOMORROW,
                            todoList: snapshot.data!.isNotEmpty
                                ? snapshot.data!
                                    .where(
                                        (element) => element.sections == SectionsType.TOMORROW.name)
                                    .toList()
                                : [],
                            postAction: () => TodoStreamBloc.fetchTodoList(),
                          ),
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
                                          ))).then(
                                (value) => TodoStreamBloc.fetchTodoList(),
                              );
                            }),
                        SizedBox(
                          height: 250,
                          child: CardWidget(
                            sectionType: SectionsType.UPCOMMING,
                            todoList: snapshot.data!.isNotEmpty
                                ? snapshot.data!
                                    .where((element) =>
                                        element.sections == SectionsType.UPCOMMING.name)
                                    .toList()
                                : [],
                            postAction: () => TodoStreamBloc.fetchTodoList(),
                          ),
                        ),
                      ],
                    )
                  : const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
