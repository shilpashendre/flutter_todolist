import 'package:flutter/material.dart';
import 'package:todolist/constants/theme.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            colors: [shadowGreyColor1, shadowGreyColor2],
          )),
      child: const Center(child: Text("No data available ")),
    );
  }
}
