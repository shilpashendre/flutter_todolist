import 'package:flutter/material.dart';
import 'package:todolist/constants/app_text_theme.dart';
import 'package:todolist/widget/icon_widget.dart';

class SectionsWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const SectionsWidget({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextTheme.titleStyle,
          ),
          const SizedBox(width: 15),
          IconWidget(onTap: onTap, iconName: Icons.add_circle_outline)
        ],
      ),
    );
  }
}
