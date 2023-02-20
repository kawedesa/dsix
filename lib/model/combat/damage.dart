class Damage {
  int pDamage;
  int mDamage;
  Damage({
    required this.pDamage,
    required this.mDamage,
  });

  factory Damage.empty() {
    return Damage(
      pDamage: 0,
      mDamage: 0,
    );
  }

  factory Damage.fromMap(Map<String, dynamic>? data) {
    return Damage(
      pDamage: data?['pDamage'],
      mDamage: data?['mDamage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pDamage': pDamage,
      'mDamage': mDamage,
    };
  }

  void increaseDamage(Damage damage) {
    pDamage += damage.pDamage;
    mDamage += damage.mDamage;
  }

  void decreaseDamage(Damage damage) {
    pDamage -= damage.pDamage;
    mDamage -= damage.mDamage;
    if (pDamage < 0) {
      pDamage = 0;
    }
    if (mDamage < 0) {
      mDamage = 0;
    }
  }
}
