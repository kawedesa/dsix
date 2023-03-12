import 'package:dsix/model/combat/position.dart';
import 'package:flutter/material.dart';

class VisionGrid {
  Path getGrid(Position position) {
    Path grid = Path()
      //Horizontal
      ..addRect(Rect.fromPoints(
          Offset(position.dx - 320, position.dy - 0.05 - 60),
          Offset(position.dx + 320, position.dy + 0.05 - 60)))
      ..addRect(Rect.fromPoints(
          Offset(position.dx - 320, position.dy - 0.05 - 30),
          Offset(position.dx + 320, position.dy + 0.05 - 30)))
      ..addRect(Rect.fromPoints(Offset(position.dx - 320, position.dy - 0.05),
          Offset(position.dx + 320, position.dy + 0.05)))
      ..addRect(Rect.fromPoints(
          Offset(position.dx - 320, position.dy - 0.05 + 30),
          Offset(position.dx + 320, position.dy + 0.05 + 30)))
      ..addRect(Rect.fromPoints(
          Offset(position.dx - 320, position.dy - 0.05 + 60),
          Offset(position.dx + 320, position.dy + 0.05 + 60)))

      //Vertical
      ..addRect(Rect.fromPoints(
          Offset(position.dx - 0.05 - 60, position.dy - 320),
          Offset(position.dx + 0.05 - 60, position.dy + 320)))
      ..addRect(Rect.fromPoints(
          Offset(position.dx - 0.05 - 30, position.dy - 320),
          Offset(position.dx + 0.05 - 30, position.dy + 320)))
      ..addRect(Rect.fromPoints(Offset(position.dx - 0.05, position.dy - 320),
          Offset(position.dx + 0.05, position.dy + 320)))
      ..addRect(Rect.fromPoints(
          Offset(position.dx - 0.05 + 30, position.dy - 320),
          Offset(position.dx + 0.05 + 30, position.dy + 320)))
      ..addRect(Rect.fromPoints(
          Offset(position.dx - 0.05 + 60, position.dy - 320),
          Offset(position.dx + 0.05 + 60, position.dy + 320)));
    return grid;
  }
}
