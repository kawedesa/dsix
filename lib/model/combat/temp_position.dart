import 'package:flutter/material.dart';

class AppTempPosition extends ChangeNotifier {
  Offset? newPosition;
  Offset? oldPosition;

  AppTempPosition({
    this.newPosition,
    this.oldPosition,
  });

  void initialize(Offset originalPosition) {
    oldPosition = originalPosition;
    newPosition = originalPosition;
  }

  void panUpdate(Offset dragPosition) {
    newPosition = Offset(
        newPosition!.dx + dragPosition.dx, newPosition!.dy + dragPosition.dy);

    notifyListeners();
  }

  void panEnd() {
    oldPosition = newPosition;
  }
}
