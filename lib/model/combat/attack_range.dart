class AttackRange {
  double min;
  double max;
  AttackRange({required this.min, required this.max});

  factory AttackRange.empty() {
    return AttackRange(min: 0, max: 0);
  }

  factory AttackRange.fromMap(Map<String, dynamic>? data) {
    return AttackRange(
      min: data?['min'] * 1.0,
      max: data?['max'] * 1.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'min': min,
      'max': max,
    };
  }

  void increase(double maxRange, double minRange) {
    max += maxRange;
    min += minRange;
  }

  void decrease(double maxRange, double minRange) {
    max -= maxRange;
    min -= minRange;
  }

  // bool cantAttack(PlayerLocation targetLocation, PlayerLocation playerLocation,
  //     bool rangedAttack) {
  //   bool withinHeight = checkHeight(
  //       targetLocation.height!, playerLocation.height!, rangedAttack);
  //   bool withinDistance = checkDistance(
  //       targetLocation.getLocation(), playerLocation.getLocation());

  //   if (withinHeight && withinDistance) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  // bool checkHeight(int targetHeight, int playerHeight, bool rangedAttack) {
  //   if (rangedAttack) {
  //     return true;
  //   }

  //   int maxRange = targetHeight + 1;
  //   int minRange = targetHeight - 1;

  //   if (playerHeight < minRange || playerHeight > maxRange) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  // bool checkDistance(Offset targetLocation, Offset playerLocation) {
  //   double distance = (targetLocation - playerLocation).distance;

  //   if (distance > this.max! / 2 || distance < this.min! / 2) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  // double setMaxRange(String mode, double vision) {
  //   switch (mode) {
  //     case 'walk':
  //       return 0;

  //     case 'wait':
  //       return 0;

  //     case 'menu':
  //       return 0;

  //     case 'attack':
  //       if (max! > vision) {
  //         return vision;
  //       } else {
  //         return max!;
  //       }
  //   }

  //   return 0.0;
  // }

  // double setMinRange(String mode) {
  //   switch (mode) {
  //     case 'walk':
  //       return 0;

  //     case 'wait':
  //       return 0;

  //     case 'menu':
  //       return 0;

  //     case 'attack':
  //       return min!;
  //   }

  //   return 0.0;
  // }
}
