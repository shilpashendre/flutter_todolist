import 'package:flutter/material.dart';
import 'package:todolist/db/todolist_database.dart';
import 'package:todolist/enums/sections_type.dart';
import 'package:todolist/model/todolist_modal.dart';
import 'package:todolist/enums/action_type.dart';
import 'package:todolist/pages/add_task_page.dart';

class CardWidget extends StatefulWidget {
  final List<TodoList> todoList;
  final SectionsType sectionType;
  const CardWidget(
      {Key? key, required this.todoList, required this.sectionType})
      : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool isLoading = false;
  @override
  void initState() {
    print('data ${widget.todoList}');
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
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.todoList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Container(
              height: 220,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: const Offset(5, 5), // changes position of shadow
                    ),
                  ],
                  gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xFF9BE9FF),
                      Color(0xFFE0F8FF),
                    ],
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 12.0),
                        child: Text(
                          widget.todoList[index].title,
                          style: const TextStyle(
                              color: Color(0xFF4A4949),
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
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
                                style: const TextStyle(
                                    color: Color(0xFF4A4949),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddTaskPage(
                                          sectionsType: widget.sectionType,
                                          item: widget.todoList[index],
                                          actionType: ActionType.EDIT)));
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.edit,
                                color: Color(0xFF353535),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              deleteItem(widget.todoList[index].id);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.delete_outline_outlined,
                                color: Color(0xFF353535),
                              ),
                            ),
                          )
                        ],
                      )
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
