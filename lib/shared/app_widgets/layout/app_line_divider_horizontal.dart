import 'package:flutter/material.dart';

class AppLineDividerHorizontal extends StatelessWidget {
  final Color color;
  final double value;

  const AppLineDividerHorizontal(
      {Key? key, required this.color, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: value,
      width: double.infinity,
      color: color,
    );
  }
}
