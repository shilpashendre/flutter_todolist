import 'package:flutter/material.dart';
import 'package:todolist/db/todolist_database.dart';
import 'package:todolist/enums/sections_type.dart';
import 'package:todolist/model/todolist_modal.dart';
import 'package:todolist/enums/action_type.dart';
import 'package:todolist/widget/app_button.dart';
import 'package:todolist/widget/app_textformfield.dart';

class AddTaskPage extends StatefulWidget {
  final ActionType actionType;
  final TodoList? item;
  final SectionsType sectionsType;
  const AddTaskPage(
      {Key? key,
      required this.actionType,
      this.item,
      required this.sectionsType})
      : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late final TextEditingController addTitleController;

  late final TextEditingController addDescriptionController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    addTitleController = TextEditingController(text: widget.item?.title);
    addDescriptionController =
        TextEditingController(text: widget.item?.description);
    super.initState();
  }

  void addOrUpdateListItem() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.item != null;

      if (isUpdating) {
        await updateListItem();
      } else {
        await addListItem();
      }
      Navigator.of(context).pop();
    }
  }

  Future updateListItem() async {
    final listItem = widget.item!.copy(
        title: addTitleController.text,
        description: addDescriptionController.text,
        sections: widget.sectionsType.name);

    await ToDoListDatabase.instance.update(listItem);
  }

  Future addListItem() async {
    final listItem = TodoList(
        title: addTitleController.text,
        description: addDescriptionController.text,
        sections: widget.sectionsType.name);

    await ToDoListDatabase.instance.create(listItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black26,
          title: Text(
            widget.actionType == ActionType.ADD ? "ADD" : "UPDATE",
          )),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Title:"),
            ),
            AppTextFormField(
                controller: addTitleController,
                labelText: "Text*",
                validator: (text) {
                  if (text != null && text.isEmpty) {
                    return "Title is required";
                  }
                  return null;
                }),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Description:"),
            ),
            AppTextFormField(
                controller: addDescriptionController, labelText: "Description"),
            const SizedBox(
              height: 20,
            ),
            AppButton(
              title: widget.actionType == ActionType.ADD ? "SAVE" : "UPDATE",
              onTap: () {
                addOrUpdateListItem();
              },
            )
          ],
        ),
      ),
    );
  }
}
