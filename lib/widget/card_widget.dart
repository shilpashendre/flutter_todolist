import 'package:flutter/material.dart';
import 'package:todolist/constants/app_text_theme.dart';
import 'package:todolist/constants/theme.dart';
import 'package:todolist/db/todolist_database.dart';
import 'package:todolist/enums/sections_type.dart';
import 'package:todolist/model/todolist_modal.dart';
import 'package:todolist/enums/action_type.dart';
import 'package:todolist/pages/add_task_page.dart';
import 'package:todolist/widget/epmty_state_widgets.dart';
import 'package:todolist/widget/icon_widget.dart';

class CardWidget extends StatefulWidget {
  final List<TodoList> todoList;
  final SectionsType sectionType;
  final VoidCallback refresh;
  const CardWidget(
      {Key? key,
      required this.todoList,
      required this.sectionType,
      required this.refresh})
      : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    ToDoListDatabase.instance.close();
    super.dispose();
  }

  void deleteItem(id) async {
    setState(() {
      isLoading = true;
    });
    await ToDoListDatabase.instance.delete(id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.todoList.isNotEmpty
        ? Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: widget.todoList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Container(
                    height: 220,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: const Offset(
                                5, 5), // changes position of shadow
                          ),
                        ],
                        gradient: const LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [shadowAppColor1, shadowAppColor2],
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 12.0),
                                  child: Text(
                                    widget.todoList[index].title,
                                    style: AppTextTheme.cardTitle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 12.0),
                                  child: Wrap(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.todoList[index].description,
                                          style: AppTextTheme.cardDescription,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconWidget(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddTaskPage(
                                                sectionsType:
                                                    widget.sectionType,
                                                item: widget.todoList[index],
                                                actionType:
                                                    ActionType.EDIT))).then(
                                        (value) => widget.refresh);
                                  },
                                  iconName: Icons.edit,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                IconWidget(
                                  onTap: () {
                                    deleteItem(widget.todoList[index].id);
                                  },
                                  iconName: Icons.delete_outline_outlined,
                                ),
                              ],
                            )
                          ]),
                    ),
                  ),
                );
              },
            ),
          )
        : const EmptyStateWidget();
  }
}
