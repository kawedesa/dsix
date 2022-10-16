import 'package:dsix/shared/app_layout.dart';
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
        fontSize: AppLayout.shortest(context) * fontSize,
        letterSpacing: AppLayout.shortest(context) * letterSpacing,
        fontWeight: FontWeight.normal,
        fontFamily: 'Poppins',
        color: color,
      ),
    );
  }
}
