import 'package:flutter/widgets.dart';

class Position {
  double dx;
  double dy;
  Position({
    required this.dx,
    required this.dy,
  });

  factory Position.empty() {
    return Position(
      dx: -1000,
      dy: -1000,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dx': dx,
      'dy': dy,
    };
  }

  factory Position.fromMap(Map<String, dynamic>? data) {
    return Position(
      dx: data?['dx'] * 1.0,
      dy: data?['dy'] * 1.0,
    );
  }

  double getDistanceFromPosition(Position position) {
    return Offset(dx - position.dx, dy - position.dy).distance;
  }

  Offset getOffset() {
    return Offset(dx, dy);
  }

  void reset() {
    dx = -1000;
    dy = -1000;
  }
}
