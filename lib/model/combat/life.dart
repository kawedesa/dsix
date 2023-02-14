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

  void setLife(String race) {
    switch (race) {
      case 'dwarf':
        max = 25;
        current = 25;
        break;
      case 'elf':
        max = 20;
        current = 20;
        break;
      case 'orc':
        max = 20;
        current = 20;
        break;
    }
  }

  void receiveDamage(int damage) {
    current -= damage;
  }

  // void setLife(String race) {
  //   if (race == 'dwarf') {
  //     max = 25;
  //   } else {
  //     max = 20;
  //   }
  // }

}
