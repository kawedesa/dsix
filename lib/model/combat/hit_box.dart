import 'package:flutter/material.dart';

class HitBox {
  Path getWithPositionOffset(String name, Offset position) {
    Path hitBox = get(name);
    hitBox = hitBox.shift(position);
    return hitBox;
  }

  Path get(String name) {
    Path hitBox = Path();

    switch (name) {
      case 'player':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(2.5, 0), const Offset(-2.5, -10)));
        break;
      case 'baby bear':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(1.5, 0), const Offset(-1.5, -2.75)));
        break;

      case 'zombie':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(3, 0), const Offset(-3, -10.5)));

        break;

      case 'giant bat':
        hitBox = Path()
          ..addRect(Rect.fromPoints(const Offset(5, -3), const Offset(-5, -6)));
        break;
      case 'skeleton':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(2.25, 0), const Offset(-2.25, -9)));
        break;
      case 'skeleton mage':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(2.25, 0), const Offset(-2.25, -9)));
        break;
      case 'skeleton warrior':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(2.25, 0), const Offset(-2.25, -10)));
        break;

      case 'demon head':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(2, -1.25), const Offset(-2, -6)));
        break;
      case 'giant frog':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(3, 1.5), const Offset(-3, -6)));
        break;
      case 'goblin':
        hitBox = Path()
          ..addRect(Rect.fromPoints(const Offset(3, 0), const Offset(-3, -7)));
        break;
      case 'basilisk':
        hitBox = Path();

        hitBox.moveTo(9, 1.5);
        hitBox.lineTo(2, -5);
        hitBox.lineTo(-7, -5);
        hitBox.lineTo(-6.5, 1.5);
        hitBox.close();
        break;
      case 'mama bear':
        hitBox = Path();
        hitBox.moveTo(4, 0);
        hitBox.lineTo(-4, 0);
        hitBox.lineTo(-4, -7);
        hitBox.lineTo(-6, -11);
        hitBox.lineTo(0, -15);
        hitBox.lineTo(6, -11);
        hitBox.lineTo(4, -7);
        hitBox.close();

        break;

      case 'gnome wizzard':
        hitBox = Path()
          ..addRect(Rect.fromPoints(const Offset(2, 0), const Offset(-2, -5)));
        break;
    }

    return hitBox;
  }
}
