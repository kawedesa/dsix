import 'package:flutter/material.dart';

class AppLineDividerVertical extends StatelessWidget {
  final Color color;
  final double value;

  const AppLineDividerVertical(
      {Key? key, required this.color, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: value,
      height: double.infinity,
      color: color,
    );
  }
}
