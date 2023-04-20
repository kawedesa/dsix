import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math.dart';

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
      dx: -10000,
      dy: -10000,
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

  double getDistanceFromPosition(Position position) {
    return Offset(dx - position.dx, dy - position.dy).distance;
  }

  Position withOffset(Offset offset) {
    return Position(
      dx: dx + offset.dx,
      dy: dy + offset.dy,
      tile: tile,
    );
  }

  Offset getOffset() {
    return Offset(dx, dy);
  }

  Vector2 getVector() {
    return Vector2(dx, dy);
  }

  void knockBack(Position actionCenter) {
    double knockBackForce = 5.0;
    Vector2 vector = getVector() - actionCenter.getVector();
    vector.normalize();

    Vector2 newPosition = getVector() + (vector * knockBackForce);

    dx = newPosition.x;
    dy = newPosition.y;
  }

  void reset() {
    dx = -10000;
    dy = -10000;
  }
}
