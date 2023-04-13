import 'package:dsix/shared/app_layout.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final double letterSpacing;
  final bool? bold;
  final Color color;
  const AppText(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.letterSpacing,
      this.bold,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: AppLayout.avarage(context) * fontSize,
        letterSpacing: AppLayout.avarage(context) * letterSpacing,
        fontWeight: (bold != null && bold == true)
            ? FontWeight.bold
            : FontWeight.normal,
        fontFamily: 'Poppins',
        color: color,
      ),
    );
  }
}
