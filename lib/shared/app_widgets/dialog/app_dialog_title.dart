import 'package:flutter/material.dart';

class AppDialogTitle extends StatelessWidget {
  final String title;
  final Color color;
  const AppDialogTitle({Key? key, required this.color, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.shortestSide * 0.08,
      color: color,
      child: Center(
        child: Text(title.toUpperCase(),
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.shortestSide * 0.035,
              fontWeight: FontWeight.bold,
              letterSpacing: MediaQuery.of(context).size.shortestSide * 0.005,
              fontFamily: 'Poppins',
              color: Colors.black,
            )),
      ),
    );
  }
}
