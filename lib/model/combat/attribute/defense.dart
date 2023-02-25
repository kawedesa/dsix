class Defense {
  int attribute;

  Defense({
    required this.attribute,
  });

  Map<String, dynamic> toMap() {
    return {
      'attribute': attribute,
    };
  }

  factory Defense.fromMap(Map<String, dynamic>? data) {
    return Defense(
      attribute: data?['attribute'],
    );
  }

  factory Defense.empty() {
    return Defense(
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
