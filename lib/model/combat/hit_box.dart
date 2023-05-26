import 'package:flutter/material.dart';

class HitBox {
  Path getPlayerHitBox(Offset position) {
    Offset shiftOffset = Offset(position.dx, position.dy + 5);

    Path hitBox = Path();
    hitBox = Path()
      ..addRect(
          Rect.fromPoints(const Offset(2.5, -5), const Offset(-2.5, -15)));
    hitBox = hitBox.shift(shiftOffset);
    return hitBox;
  }

  Path playerHitBox() {
    Path hitBox = Path();
    hitBox = Path()
      ..addRect(
          Rect.fromPoints(const Offset(2.5, -5), const Offset(-2.5, -15)));
    return hitBox;
  }

  Path getNpcHitBox(String name, Offset position) {
    Offset shiftOffset = Offset(position.dx, position.dy + 5);

    Path hitBox = npcHitBox(name);
    hitBox = hitBox.shift(shiftOffset);
    return hitBox;
  }

  Path getDeadNpcHitBox(String name, Offset position) {
    Path hitBox = deadNpcHitBox(name);
    hitBox = hitBox.shift(position);
    return hitBox;
  }

  Path npcHitBox(String name) {
    Path hitBox = Path();

    switch (name) {
      case 'baby bear':
        hitBox = Path()
          ..addRect(Rect.fromPoints(
              const Offset(1.5, -5), const Offset(-1.5, -7.75)));
        break;
      case 'basilisk':
        hitBox = Path();
        hitBox.moveTo(9, -5.5);
        hitBox.lineTo(2, -12);
        hitBox.lineTo(-7, -12);
        hitBox.lineTo(-6.5, -5.5);
        hitBox.close();
        break;
      case 'demon head':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(2, -6.25), const Offset(-2, -11)));
        break;
      case 'giant bat':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(5, -8), const Offset(-5, -11)));
        break;
      case 'giant frog':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(3, -3.5), const Offset(-3, -11)));
        break;
      case 'gnome wizzard':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(2, -5), const Offset(-2, -10)));
        break;
      case 'goblin bandit':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(3, -5), const Offset(-3, -13)));
        break;
      case 'goblin marksman':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(3, -5), const Offset(-3, -12)));
        break;
      case 'mama bear':
        hitBox = Path();
        hitBox.moveTo(4, -7);
        hitBox.lineTo(-4, -7);
        hitBox.lineTo(-4, -14);
        hitBox.lineTo(-6, -18);
        hitBox.lineTo(0, -22);
        hitBox.lineTo(6, -18);
        hitBox.lineTo(4, -14);
        hitBox.close();
        break;
      case 'skeleton':
        hitBox = Path()
          ..addRect(Rect.fromPoints(
              const Offset(2.25, -5), const Offset(-2.25, -14)));
        break;
      case 'skeleton mage':
        hitBox = Path()
          ..addRect(Rect.fromPoints(
              const Offset(2.25, -5), const Offset(-2.25, -14)));
        break;
      case 'skeleton warrior':
        hitBox = Path()
          ..addRect(Rect.fromPoints(
              const Offset(2.25, -5), const Offset(-2.25, -14)));
        break;
      case 'zombie':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(3, -5), const Offset(-3, -15.5)));
        break;
    }

    return hitBox;
  }

  Path deadNpcHitBox(String name) {
    Path hitBox = Path();

    switch (name) {
      case 'baby bear':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(1.5, 0), const Offset(-1.5, -2.75)));
        break;
      case 'basilisk':
        hitBox = Path()
          ..addRect(Rect.fromPoints(const Offset(6, 1), const Offset(-6, -4)));
        break;
      case 'demon head':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(2.5, -1), const Offset(-2.5, -4)));
        break;
      case 'giant bat':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(4.5, -1.5), const Offset(-4.5, -4)));
        break;
      case 'giant frog':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(3, -0.5), const Offset(-3, -3.5)));
        break;
      case 'gnome wizzard':
        hitBox = Path()
          ..addRect(Rect.fromPoints(const Offset(2, -1), const Offset(-2, -4)));
        break;
      case 'goblin bandit':
        hitBox = Path();
        hitBox.moveTo(6, 0);
        hitBox.lineTo(-6, 0);
        hitBox.lineTo(-3, -6);
        hitBox.lineTo(3, -6);
        hitBox.close();

        break;
      case 'goblin marksman':
        hitBox = Path();
        hitBox.moveTo(6, 0);
        hitBox.lineTo(-6, 0);
        hitBox.lineTo(-3, -5);
        hitBox.lineTo(3, -5);
        hitBox.close();
        break;
      case 'mama bear':
        hitBox = Path();
        hitBox.moveTo(6, 4);
        hitBox.lineTo(-3, 4);
        hitBox.lineTo(-10, -2);
        hitBox.lineTo(-3, -5);
        hitBox.lineTo(6, -5);
        hitBox.lineTo(8, -2);
        hitBox.close();
        break;
      case 'skeleton':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(2.25, 0), const Offset(-2.25, -5)));
        break;
      case 'skeleton mage':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(2.25, 0), const Offset(-2.25, -5)));
        break;
      case 'skeleton warrior':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(2.25, 0), const Offset(-2.25, -5)));
        break;
      case 'zombie':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(4, -1), const Offset(-4, -6.5)));
        break;
    }

    return hitBox;
  }

  Path propHitBox(String name, String type) {
    Path hitBox = Path();

    switch (name) {
      case 'chest':
        hitBox = Path()
          ..addRect(
              Rect.fromPoints(const Offset(4, -1), const Offset(-4, -6.5)));
        break;

      case 'vase':
        switch (type) {
          case 'blue':
            hitBox = Path();
            hitBox.moveTo(1.5, -0.5);
            hitBox.lineTo(-1.5, -0.5);
            hitBox.lineTo(-2.5, -1.5);
            hitBox.lineTo(-2.5, -4.5);
            hitBox.lineTo(-1, -6);
            hitBox.lineTo(1, -6);
            hitBox.lineTo(2.5, -4.5);
            hitBox.lineTo(2.5, -1.5);
            hitBox.close();
            break;
          case 'brown':
            hitBox = Path();
            hitBox.moveTo(1.5, -1.5);
            hitBox.lineTo(-1.5, -1.5);
            hitBox.lineTo(-3, -3);
            hitBox.lineTo(-3, -5.5);
            hitBox.lineTo(-1, -7.5);
            hitBox.lineTo(1, -7.5);
            hitBox.lineTo(3, -5.5);
            hitBox.lineTo(3, -3);
            hitBox.close();
            break;
          case 'orange':
            hitBox = Path();
            hitBox.moveTo(1, -2);
            hitBox.lineTo(-1, -2);
            hitBox.lineTo(-3, -4);
            hitBox.lineTo(-3, -6);
            hitBox.lineTo(-1, -8);
            hitBox.lineTo(1, -8);
            hitBox.lineTo(3, -6);
            hitBox.lineTo(3, -4);
            hitBox.close();
            break;
          case 'pink':
            hitBox = Path();
            hitBox.moveTo(0, -2);
            hitBox.lineTo(-3.5, -6);
            hitBox.lineTo(-1.5, -8.5);
            hitBox.lineTo(1.5, -8.5);
            hitBox.lineTo(3.5, -6);
            hitBox.close();

            break;
          case 'yellow':
            hitBox = Path();
            hitBox.moveTo(1, -2);
            hitBox.lineTo(-1, -2);
            hitBox.lineTo(-3, -4);
            hitBox.lineTo(-3, -6);
            hitBox.lineTo(-1, -8);
            hitBox.lineTo(1, -8);
            hitBox.lineTo(3, -6);
            hitBox.lineTo(3, -4);
            hitBox.close();
            break;
        }

        break;
    }

    return hitBox;
  }
}
