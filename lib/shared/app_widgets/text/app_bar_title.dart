import 'package:dsix/shared/app_layout.dart';
import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final String title;
  final Color color;
  const AppBarTitle({Key? key, required this.title, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: AppLayout.shortest(context) * 0.025,
          letterSpacing: AppLayout.shortest(context) * 0.008,
          fontFamily: 'Poppins',
          color: color,
        ));
  }
}
