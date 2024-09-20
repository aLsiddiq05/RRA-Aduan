import 'package:flutter/material.dart';

class CustomMBAvatar extends StatelessWidget {
  final String initial;
  final Color backgroundColor;
  final Color textColor;

  const CustomMBAvatar(
      {Key? key,
      required this.initial,
      required this.backgroundColor,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      child: Text(initial,
          style: TextStyle(
              color: textColor, fontSize: 25, fontWeight: FontWeight.bold)),
    );
  }
}
