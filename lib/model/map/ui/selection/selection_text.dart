import 'package:flutter/material.dart';

class SelectionText extends StatelessWidget {
  final String text;
  final double fontSize;
  final double? letterSpacing;
  final bool? isBold;
  final Color? color;
  const SelectionText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.letterSpacing,
      this.isBold,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        letterSpacing: (letterSpacing == null) ? 2.5 : letterSpacing,
        fontWeight: (isBold == null)
            ? FontWeight.bold
            : (isBold!)
                ? FontWeight.bold
                : FontWeight.normal,
        fontFamily: 'Poppins',
        color: (color == null) ? Colors.white : color,
      ),
    );
  }
}
