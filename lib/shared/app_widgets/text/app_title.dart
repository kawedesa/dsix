import 'package:dsix/shared/app_layout.dart';
import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final String title;
  final Color color;
  const AppTitle({Key? key, required this.title, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title.toUpperCase(),
        style: TextStyle(
          shadows: [Shadow(color: color, offset: const Offset(0, -10))],
          decoration: TextDecoration.underline,
          decorationColor: color,
          color: Colors.transparent,
          fontSize: AppLayout.shortest(context) * 0.075,
          letterSpacing: AppLayout.shortest(context) * 0.01,
          fontFamily: 'Poppins',
        ));
  }
}
