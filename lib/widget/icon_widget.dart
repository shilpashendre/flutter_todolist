import 'package:flutter/material.dart';
import 'package:todolist/constants/theme.dart';

class IconWidget extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconName;
  const IconWidget({Key? key, required this.onTap, required this.iconName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Icon(iconName, color: iconColor),
      ),
    );
  }
}
