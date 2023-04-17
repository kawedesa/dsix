import 'package:dsix/shared/shared_widgets/text/app_bar_text.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  SnackBar getSnackBar(String text, Color color) {
    return SnackBar(
      duration: const Duration(seconds: 1),
      content: SizedBox(
          height: 50,
          child: Center(
            child: AppBarText(
              text: text,
              fontSize: 0.02,
              letterSpacing: 0.004,
              color: Colors.white,
            ),
          )),
      backgroundColor: color.withAlpha(200),
    );
  }
}
