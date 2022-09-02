import 'package:flutter/material.dart';
import 'package:todolist/constants/strings.dart';
import 'package:todolist/enums/sections_type.dart';
import 'package:todolist/model/todolist_model.dart';
import 'package:todolist/enums/action_type.dart';
import 'package:todolist/streams/todo_stream_bloc.dart';
import 'package:todolist/widget/app_button.dart';
import 'package:todolist/widget/app_textformfield.dart';

class AddTaskPage extends StatefulWidget {
  final ActionType actionType;
  final TodoList? item;
  final SectionsType sectionsType;
  const AddTaskPage({
    Key? key,
    required this.actionType,
    this.item,
    required this.sectionsType,
  }) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late final TextEditingController addTitleController;

  late final TextEditingController addDescriptionController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    addTitleController = TextEditingController(text: widget.item?.title);
    addDescriptionController =
        TextEditingController(text: widget.item?.description);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black26,
          title: Text(
            widget.actionType == ActionType.ADD ? "ADD" : "UPDATE",
          )),
      body: StreamBuilder<bool>(
          stream: TodoStreamBloc.addOrUpdateStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              Navigator.of(context).pop();
            } else if (snapshot.hasError) {
              showErrorDialog(context);
            }

            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(Strings.title),
                  ),
                  AppTextFormField(
                      controller: addTitleController,
                      labelText: Strings.titleInputLabel,
                      validator: (text) {
                        if (text != null && text.isEmpty) {
                          return Strings.titleFieldErr;
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(Strings.description),
                  ),
                  AppTextFormField(
                      controller: addDescriptionController,
                      labelText: Strings.description),
                  const SizedBox(
                    height: 20,
                  ),
                  AppButton(
                    title: widget.actionType == ActionType.ADD
                        ? Strings.globalSave
                        : Strings.globalUpdate,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        widget.item != null
                            ? TodoStreamBloc.updateTodo(
                                widget.item!.id ?? 0,
                                addTitleController.text,
                                addDescriptionController.text,
                                widget.sectionsType.name)
                            : TodoStreamBloc.addTodo(
                                addTitleController.text,
                                addDescriptionController.text,
                                widget.sectionsType.name);
                      }
                    },
                  )
                ],
              ),
            );
          }),
    );
  }

  showErrorDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text(
        Strings.globalOk,
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(Strings.errorTitle),
          content: const Text(Strings.errorInfo),
          actions: [
            okButton,
          ],
        );
      },
    );
  }
}
