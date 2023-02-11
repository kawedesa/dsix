import 'package:dsix/model/combat/position.dart';
import 'package:flutter/material.dart';

class AppTempPosition extends ChangeNotifier {
  Position? newPosition;
  Position? oldPosition;

  AppTempPosition({
    this.newPosition,
    this.oldPosition,
  });

  void initialize(Position originalPosition) {
    oldPosition = originalPosition;
    newPosition = originalPosition;
  }

  void panUpdate(Offset dragPosition) {
    newPosition = Position(
        dx: newPosition!.dx + dragPosition.dx,
        dy: newPosition!.dy + dragPosition.dy);

    notifyListeners();
  }

  void panEnd() {
    oldPosition = newPosition;
  }
}
