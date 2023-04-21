class Life {
  int current;
  int max;
  Life({required this.current, required this.max});

  factory Life.empty() {
    return Life(
      current: 0,
      max: 0,
    );
  }

  factory Life.fromMap(Map<String, dynamic>? data) {
    return Life(
      current: data?['current'],
      max: data?['max'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'current': current,
      'max': max,
    };
  }

  void setRaceLife(String race) {
    switch (race) {
      case 'dwarf':
        setMaxLife(26);
        break;
      case 'elf':
        setMaxLife(14);
        break;
      case 'orc':
        setMaxLife(20);
        break;
    }
  }

  void setMaxLife(int maxLife) {
    max = maxLife;
    current = max;
  }

  void heal(int value) {
    current += value;
    if (current > max) {
      current = max;
    }
  }

  void receiveDamage(int damage) {
    current -= damage;
  }

  bool isDead() {
    if (current < 1) {
      return true;
    } else {
      return false;
    }
  }

  bool isAlive() {
    if (current > 0) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    current = max;
  }
}
