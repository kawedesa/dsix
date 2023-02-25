class Movement {
  int attribute;

  Movement({
    required this.attribute,
  });

  Map<String, dynamic> toMap() {
    return {
      'attribute': attribute,
    };
  }

  factory Movement.fromMap(Map<String, dynamic>? data) {
    return Movement(
      attribute: data?['attribute'],
    );
  }

  factory Movement.empty() {
    return Movement(
      attribute: 0,
    );
  }

  void setAttribute(int value) {
    attribute = value;
  }

  void addAttribute() {
    attribute++;
  }

  void removeAttribute() {
    attribute--;
  }

  double maxRange() {
    double range = attribute * 10 + 50;

    if (range < 0) {
      range = 0;
    }
    return range;
  }
}
