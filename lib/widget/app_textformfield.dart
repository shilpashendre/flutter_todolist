import 'package:flutter/material.dart';
import 'package:todolist/constants/theme.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String? text)? validator;

  const AppTextFormField(
      {Key? key,
      required this.controller,
      required this.labelText,
      this.validator})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppTextFormFieldState();
  }
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.labelText,
          fillColor: Colors.white,
          floatingLabelStyle: const TextStyle(color: Colors.black45),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: grey, width: 1),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: grey,
              width: 1.0,
            ),
          ),
        ),
        validator: widget.validator,
      ),
    );
  }
}
