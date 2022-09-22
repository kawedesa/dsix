class PlayerLife {
  int current;
  int max;
  PlayerLife({required this.current, required this.max});

  factory PlayerLife.empty() {
    return PlayerLife(
      current: 0,
      max: 0,
    );
  }

  factory PlayerLife.fromMap(Map<String, dynamic>? data) {
    return PlayerLife(
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
    if (race == 'dwarf') {
      max = 25;
    } else {
      max = 20;
    }
  }
}
