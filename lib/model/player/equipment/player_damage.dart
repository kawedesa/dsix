class PlayerDamage {
  int pDamage;
  int mDamage;
  int tempDamage;
  PlayerDamage({
    required this.pDamage,
    required this.mDamage,
    required this.tempDamage,
  });

  factory PlayerDamage.empty() {
    return PlayerDamage(
      pDamage: 0,
      mDamage: 0,
      tempDamage: 0,
    );
  }

  factory PlayerDamage.fromMap(Map<String, dynamic>? data) {
    return PlayerDamage(
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

  void increasePDamage(int value) {
    pDamage = pDamage + value;
  }

  void decreasePDamage(int value) {
    pDamage = pDamage - value;
    if (pDamage < 0) {
      pDamage = 0;
    }
  }

  void increaseMDamage(int value) {
    mDamage = mDamage + value;
  }

  void decreaseMDamage(int value) {
    mDamage = mDamage - value;
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
