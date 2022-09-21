import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final double letterSpacing;
  final Color color;
  const AppText(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.letterSpacing,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.shortestSide * fontSize,
        letterSpacing: MediaQuery.of(context).size.shortestSide * letterSpacing,
        fontWeight: FontWeight.normal,
        fontFamily: 'Poppins',
        color: color,
      ),
    );
  }
}
