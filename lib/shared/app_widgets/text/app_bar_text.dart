import 'package:dsix/shared/app_layout.dart';
import 'package:flutter/material.dart';

class AppBarText extends StatelessWidget {
  final String text;
  final double fontSize;
  final double letterSpacing;
  final Color color;
  const AppBarText(
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
        fontSize: AppLayout.height(context) * fontSize,
        letterSpacing: AppLayout.height(context) * letterSpacing,
        fontWeight: FontWeight.normal,
        fontFamily: 'Poppins',
        color: color,
      ),
    );
  }
}
