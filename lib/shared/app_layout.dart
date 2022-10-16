import 'package:flutter/material.dart';

class AppLayout {
  static double avarage(context) {
    return (MediaQuery.of(context).size.width +
            MediaQuery.of(context).size.height) *
        0.5;
  }

  static double shortest(context) {
    return MediaQuery.of(context).size.shortestSide;
  }

  static double height(context) {
    return MediaQuery.of(context).size.height;
  }

  static double width(context) {
    return MediaQuery.of(context).size.width;
  }
}
