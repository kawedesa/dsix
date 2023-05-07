import 'package:dsix/model/combat/position.dart';
import 'package:flutter/material.dart';

class TempPosition extends ChangeNotifier {
  Position newPosition = Position.empty();
  Position oldPosition = Position.empty();
  double distanceMoved = 0;

  void initialize(Position originalPosition) {
    oldPosition = originalPosition;
    newPosition = originalPosition;
    distanceMoved = 0;
  }

  void panUpdate(Offset dragPosition, bool inGrass) {
    newPosition = Position(
        dx: newPosition.dx + dragPosition.dx,
        dy: newPosition.dy + dragPosition.dy,
        inGrass: inGrass);
    calculateDistance();

    notifyListeners();
  }

  void panEnd() {
    oldPosition = newPosition;
  }

  void calculateDistance() {
    distanceMoved =
        Offset(oldPosition.dx - newPosition.dx, oldPosition.dy - newPosition.dy)
                .distance *
            2;
  }
}
