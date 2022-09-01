import 'package:flutter/material.dart';
import 'package:todolist/constants/theme.dart';

class AppTextTheme {
  static const TextStyle titleStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

  static const TextStyle cardTitle = TextStyle(
      color: Color(0xFF4A4949), fontSize: 16, fontWeight: FontWeight.w700);
  static const TextStyle buttonTextStyle =
      TextStyle(color: paper, fontSize: 14, letterSpacing: 1.6);
  static const TextStyle cardDescription =   TextStyle(
      color: Color(0xFF4A4949), fontSize: 14, fontWeight: FontWeight.w300);
}
