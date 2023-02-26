class Vision {
  int attribute;

  Vision({
    required this.attribute,
  });

  Map<String, dynamic> toMap() {
    return {
      'attribute': attribute,
    };
  }

  factory Vision.fromMap(Map<String, dynamic>? data) {
    return Vision(
      attribute: data?['attribute'],
    );
  }

  factory Vision.empty() {
    return Vision(
      attribute: 0,
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
    double range = attribute * 40 + 100;

    return range;
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
