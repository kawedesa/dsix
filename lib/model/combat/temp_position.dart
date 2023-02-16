import 'package:dsix/model/combat/position.dart';
import 'package:flutter/material.dart';

class AppTempPosition extends ChangeNotifier {
  Position? newPosition;
  Position? oldPosition;
  double distanceMoved = 0;

  AppTempPosition({
    this.newPosition,
    this.oldPosition,
  });

  void initialize(Position originalPosition) {
    oldPosition = originalPosition;
    newPosition = originalPosition;
    distanceMoved = 0;
  }

  void panUpdate(Offset dragPosition) {
    newPosition = Position(
        dx: newPosition!.dx + dragPosition.dx,
        dy: newPosition!.dy + dragPosition.dy);
    calculateDistance();

    notifyListeners();
  }

  void panEnd() {
    oldPosition = newPosition;
  }

  void calculateDistance() {
    distanceMoved = Offset(oldPosition!.dx - newPosition!.dx,
                oldPosition!.dy - newPosition!.dy)
            .distance *
        2;
  }
}
