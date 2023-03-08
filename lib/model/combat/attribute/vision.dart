import 'dart:math';

class Vision {
  int attribute;
  int tempVision;

  Vision({
    required this.attribute,
    required this.tempVision,
  });

  Map<String, dynamic> toMap() {
    return {
      'attribute': attribute,
      'tempVision': tempVision,
    };
  }

  factory Vision.fromMap(Map<String, dynamic>? data) {
    return Vision(
      attribute: data?['attribute'],
      tempVision: data?['tempVision'],
    );
  }

  factory Vision.empty() {
    return Vision(
      attribute: 0,
      tempVision: 0,
    );
  }

  void setAttribute(int value) {
    attribute = value;
  }

  void addAttribute() {
    attribute++;
  }

  void removeAttribute() {
    attribute--;
  }

  double getRange() {
    double range = (attribute * 40) + tempVision + 100;

    return range;
  }

  void look() {
    tempVision = 0;

    int roll1 = Random().nextInt(6) + 1;
    int roll2 = Random().nextInt(6) + 1;

    int result = roll1 + roll2 + attribute;

    if (result > 14) {
      tempVision = 60;
    }

    if (result > 11 && result < 15) {
      tempVision = 55;
    }

    if (result > 9 && result < 12) {
      tempVision = 50;
    }
    if (result > 6 && result < 10) {
      tempVision = 35;
    }
    if (result < 7) {
      tempVision = 0;
    }
  }

  void resetTempVision() {
    tempVision = 0;
  }

  // factory PlayerVision.set(String race) {
  //   double vision;
  //   if (race == 'elf') {
  //     vision = 150.0;
  //   } else {
  //     vision = 120.0;
  //   }

  //   return PlayerVision(
  //     tempVision: 0,
  //     heightBonus: 0,
  //     vision: vision,
  //     canSeeInvisible: false,
  //   );
  // }

  // void seeInvisible(String gameID, String playerIndex) {
  //   this.canSeeInvisible = true;
  //   update(gameID, playerIndex);
  // }

  // void setHeight(String gameID, String playerIndex, int height) {
  //   this.heightBonus = height * 10;

  //   update(gameID, playerIndex);
  // }

  // bool canSeeEnemyPlayer(
  //     PlayerLocation target, PlayerLocation player, TotalArea tallGrass) {
  //   double distanceFromTarget =
  //       (target.getLocation() - player.getLocation()).distance;

  //   if (target.isVisible == true && distanceFromTarget < getRange() / 2) {
  //     return true;
  //   }

  //   if (target.isVisible == false &&
  //       this.canSeeInvisible == true &&
  //       distanceFromTarget < getRange() / 2) {
  //     return true;
  //   }

  //   if (tallGrass.inTheSameArea(target.getLocation(), player.getLocation()) &&
  //       distanceFromTarget < getRange() / 2) {
  //     return true;
  //   }

  //   return false;
  // }

  // bool canSeeLoot(Offset targetLocation, Offset playerLocation) {
  //   double distanceFromTarget = (targetLocation - playerLocation).distance;

  //   if (distanceFromTarget < getRange() / 2) {
  //     return true;
  //   }

  //   return false;
  // }

  // double getRange() {
  //   return (this.vision! + this.tempVision! + this.heightBonus!);
  // }

  // double? setVisionRange(String mode) {
  //   switch ('mode') {
  //     case 'walk':
  //       return this.vision;

  //     case 'wait':
  //       return this.vision;

  //     case 'menu':
  //       return 6;

  //     case 'attack':
  //       return 0.0;

  //     case 'dead':
  //       return 0.0;
  //   }
  // }

  // void reset() {
  //   this.canSeeInvisible = false;
  //   this.tempVision = 0;
  // }

  // void update(String gameID, String playerIndex) async {
  //   final database = FirebaseFirestore.instance.collection('game');

  //   await database.doc(gameID).collection('players').doc(playerIndex).update({
  //     'vision': toMap(),
  //   });
  // }
}
