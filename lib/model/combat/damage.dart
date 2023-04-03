class Damage {
  int pierce;
  int pDamage;
  int mDamage;
  int rawDamage;
  Damage(
      {required this.pierce,
      required this.pDamage,
      required this.mDamage,
      required this.rawDamage});

  factory Damage.empty() {
    return Damage(
      pierce: 0,
      pDamage: 0,
      mDamage: 0,
      rawDamage: 0,
    );
  }

  factory Damage.fromMap(Map<String, dynamic>? data) {
    return Damage(
      pierce: data?['pierce'],
      pDamage: data?['pDamage'],
      mDamage: data?['mDamage'],
      rawDamage: data?['rawDamage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pierce': pierce,
      'pDamage': pDamage,
      'mDamage': mDamage,
      'rawDamage': rawDamage,
    };
  }
}
