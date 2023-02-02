import '../item/item.dart';

class Damage {
  int pDamage;
  int mDamage;
  int tempDamage;
  Damage({
    required this.pDamage,
    required this.mDamage,
    required this.tempDamage,
  });

  factory Damage.empty() {
    return Damage(
      pDamage: 0,
      mDamage: 0,
      tempDamage: 0,
    );
  }

  factory Damage.fromMap(Map<String, dynamic>? data) {
    return Damage(
      pDamage: data?['pDamage'],
      mDamage: data?['mDamage'],
      tempDamage: data?['tempDamage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pDamage': pDamage,
      'mDamage': mDamage,
      'tempDamage': tempDamage,
    };
  }

  void increaseDamage(Item item) {
    pDamage += item.pDamage;
    mDamage += item.mDamage;
  }

  void decreaseDamage(Item item) {
    pDamage -= item.pDamage;
    mDamage -= item.mDamage;
    if (pDamage < 0) {
      pDamage = 0;
    }
    if (mDamage < 0) {
      mDamage = 0;
    }
  }

  void increaseTempDamage(int value) {
    tempDamage = tempDamage + value;
  }

  void decreaseTempDamage(int value) {
    tempDamage = tempDamage - value;
    if (tempDamage < 0) {
      tempDamage = 0;
    }
  }

  void resetTempDamage() {
    tempDamage = 0;
  }
}
