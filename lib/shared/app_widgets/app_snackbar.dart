import 'package:dsix/shared/app_widgets/text/app_bar_text.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  SnackBar getSnackBar(String text, Color color) {
    return SnackBar(
      content: SizedBox(
          height: 100,
          child: Center(
            child: AppBarText(
              text: text,
              fontSize: 0.03,
              letterSpacing: 0.005,
              color: Colors.white,
            ),
          )),
      backgroundColor: color,
    );
  }
}
