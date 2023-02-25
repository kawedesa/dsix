class Power {
  int attribute;

  Power({
    required this.attribute,
  });

  Map<String, dynamic> toMap() {
    return {
      'attribute': attribute,
    };
  }

  factory Power.fromMap(Map<String, dynamic>? data) {
    return Power(
      attribute: data?['attribute'],
    );
  }

  factory Power.empty() {
    return Power(
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
}
