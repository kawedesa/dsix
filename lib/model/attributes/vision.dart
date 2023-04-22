class Vision {
  int attribute;
  int tempVision;
  bool canSeeInvisible;

  Vision({
    required this.attribute,
    required this.tempVision,
    required this.canSeeInvisible,
  });

  Map<String, dynamic> toMap() {
    return {
      'attribute': attribute,
      'tempVision': tempVision,
      'canSeeInvisible': canSeeInvisible,
    };
  }

  factory Vision.fromMap(Map<String, dynamic>? data) {
    return Vision(
      attribute: data?['attribute'],
      tempVision: data?['tempVision'],
      canSeeInvisible: data?['canSeeInvisible'],
    );
  }

  factory Vision.empty() {
    return Vision(
      attribute: 0,
      tempVision: 0,
      canSeeInvisible: false,
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

  double getRange() {
    double range = (attribute * 40) + tempVision + 100;

    return range;
  }

  void look() {
    tempVision = attribute * 20;
    canSeeInvisible = true;
  }

  void resetTempVision() {
    tempVision = 0;
    canSeeInvisible = false;
  }
}
