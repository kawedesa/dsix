import 'package:flutter/widgets.dart';

class Position {
  double dx;
  double dy;
  String tile;
  Position({
    required this.dx,
    required this.dy,
    required this.tile,
  });

  factory Position.empty() {
    return Position(
      dx: -1000,
      dy: -1000,
      tile: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dx': dx,
      'dy': dy,
      'tile': tile,
    };
  }

  factory Position.fromMap(Map<String, dynamic>? data) {
    return Position(
      dx: data?['dx'] * 1.0,
      dy: data?['dy'] * 1.0,
      tile: data?['tile'],
    );
  }

  double getDistanceFromPoint(Offset point) {
    return Offset(dx - point.dx, dy - point.dy).distance;
  }

  Offset getOffset() {
    return Offset(dx, dy);
  }

  void reset() {
    dx = -1000;
    dy = -1000;
  }
}
