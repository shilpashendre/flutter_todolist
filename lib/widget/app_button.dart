import 'package:flutter/material.dart';
import 'package:todolist/constants/app_text_theme.dart';
import 'package:todolist/constants/theme.dart';

class AppButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  const AppButton({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppButtondState();
  }
}

class _AppButtondState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
          onPressed: widget.onTap,
          child: Container(
              decoration: const BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  widget.title,
                  style: AppTextTheme.buttonTextStyle,
                  textAlign: TextAlign.center,
                ),
              ))),
    );
  }
}
