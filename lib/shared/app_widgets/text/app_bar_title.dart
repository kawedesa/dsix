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
          fontWeight: FontWeight.w500,
          fontSize: MediaQuery.of(context).size.shortestSide * 0.025,
          letterSpacing: MediaQuery.of(context).size.shortestSide * 0.008,
          fontFamily: 'Poppins',
          color: color,
        ));
  }
}
