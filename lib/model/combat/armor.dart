import '../item/item.dart';
import 'damage.dart';

class Armor {
  int pArmor;
  int mArmor;
  int tempArmor;
  Armor({
    required this.pArmor,
    required this.mArmor,
    required this.tempArmor,
  });

  factory Armor.fromMap(Map<String, dynamic>? data) {
    return Armor(
      pArmor: data?['pArmor'],
      mArmor: data?['mArmor'],
      tempArmor: data?['tempArmor'],
    );
  }

  factory Armor.empty() {
    return Armor(
      pArmor: 0,
      mArmor: 0,
      tempArmor: 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pArmor': pArmor,
      'mArmor': mArmor,
      'tempArmor': tempArmor,
    };
  }

  void increaseArmor(Item item) {
    pArmor += item.pArmor;
    mArmor += item.mArmor;
  }

  void decreaseArmor(Item item) {
    pArmor -= item.pArmor;
    mArmor -= item.mArmor;
    if (pArmor < 0) {
      pArmor = 0;
    }
    if (mArmor < 0) {
      mArmor = 0;
    }
  }

  void increaseTempArmor(int value) {
    tempArmor = tempArmor + value;
  }

  void decreaseTempArmor(int value) {
    tempArmor = tempArmor - value;
    if (tempArmor < 0) {
      tempArmor = 0;
    }
  }

  void resetTempArmor() {
    tempArmor = 0;
  }

  int calculateDamage(Damage rawDamage) {
    int pDamage = rawDamage.pDamage - pArmor;
    if (pDamage < 0) {
      pDamage = 0;
    }
    int mDamage = rawDamage.mDamage - mArmor;
    if (mDamage < 0) {
      mDamage = 0;
    }
    int tempDamage = rawDamage.tempDamage - tempArmor;
    if (tempDamage < 0) {
      tempDamage = 0;
    }

    int totalDamage = pDamage + mDamage + tempDamage;

    print(totalDamage);

    return totalDamage;
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


