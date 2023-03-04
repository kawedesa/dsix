class Damage {
  int pDamage;
  int mDamage;
  int rawDamage;
  Damage(
      {required this.pDamage, required this.mDamage, required this.rawDamage});

  factory Damage.empty() {
    return Damage(
      pDamage: 0,
      mDamage: 0,
      rawDamage: 0,
    );
  }

  factory Damage.fromMap(Map<String, dynamic>? data) {
    return Damage(
      pDamage: data?['pDamage'],
      mDamage: data?['mDamage'],
      rawDamage: data?['rawDamage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pDamage': pDamage,
      'mDamage': mDamage,
      'rawDamage': rawDamage,
    };
  }

  // void increaseDamage(Damage damage) {
  //   pDamage += damage.pDamage;
  //   mDamage += damage.mDamage;
  // }

  // void decreaseDamage(Damage damage) {
  //   pDamage -= damage.pDamage;
  //   mDamage -= damage.mDamage;
  //   if (pDamage < 0) {
  //     pDamage = 0;
  //   }
  //   if (mDamage < 0) {
  //     mDamage = 0;
  //   }
  // }
}
