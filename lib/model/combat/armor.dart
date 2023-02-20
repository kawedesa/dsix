import 'damage.dart';

class Armor {
  int pArmor;
  int mArmor;
  Armor({
    required this.pArmor,
    required this.mArmor,
  });

  factory Armor.fromMap(Map<String, dynamic>? data) {
    return Armor(
      pArmor: data?['pArmor'],
      mArmor: data?['mArmor'],
    );
  }

  factory Armor.empty() {
    return Armor(
      pArmor: 0,
      mArmor: 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pArmor': pArmor,
      'mArmor': mArmor,
    };
  }

  void increaseArmor(Armor armor) {
    pArmor += armor.pArmor;
    mArmor += armor.mArmor;
  }

  void decreaseArmor(Armor armor) {
    pArmor -= armor.pArmor;
    mArmor -= armor.mArmor;
    if (pArmor < 0) {
      pArmor = 0;
    }
    if (mArmor < 0) {
      mArmor = 0;
    }
  }
}
  // int calculateArmor(PlayerAttack attack) {
  //   if (this.tempArmor! > 0) {
  //     return calculateTempArmor(attack);
  //   }
  //   return calculateDamageReceived(attack);
  // }

  // int calculateTempArmor(PlayerAttack attack) {
  //   int totalDamageReceived =
  //       attack.totalDamage() - this.tempArmor! - this.pArmor! - this.mArmor!;

  //   decreaseTempArmor(attack.totalDamage());

  //   if (totalDamageReceived < 0) {
  //     totalDamageReceived = 0;
  //   }

  //   return totalDamageReceived;
  // }

  // int calculateDamageReceived(PlayerAttack attack) {
  //   int damageLeftOver = 0;
  //   int protectionLeftOver = 0;

  //   int pDamageCalculation = attack.pDamage! - this.pArmor!;
  //   if (pDamageCalculation >= 0) {
  //     damageLeftOver += pDamageCalculation;
  //   } else {
  //     protectionLeftOver -= pDamageCalculation;
  //   }

  //   int mDamageCalculation = attack.mDamage! - this.mArmor!;
  //   if (mDamageCalculation >= 0) {
  //     damageLeftOver += mDamageCalculation;
  //   } else {
  //     protectionLeftOver -= mDamageCalculation;
  //   }

  //   int partialDamage = attack.randomDamage! - protectionLeftOver;
  //   if (partialDamage < 1) {
  //     partialDamage = 0;
  //   }

  //   int totalDamageReceived = partialDamage + damageLeftOver;

  //   if (totalDamageReceived < 0) {
  //     totalDamageReceived = 0;
  //   }
  //   return totalDamageReceived;
  // }


