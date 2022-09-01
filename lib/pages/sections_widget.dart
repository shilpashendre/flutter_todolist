import 'package:flutter/material.dart';

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
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 15),
          InkWell(onTap: onTap, child: const Icon(Icons.add_circle_outline))
        ],
      ),
    );
  }
}
