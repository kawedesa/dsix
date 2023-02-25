class Range {
  double min;
  double max;
  double width;
  String type;
  Range(
      {required this.min,
      required this.max,
      required this.width,
      required this.type});

  factory Range.empty() {
    return Range(min: 0, max: 0, width: 0, type: 'rectangle');
  }

  factory Range.fromMap(Map<String, dynamic>? data) {
    return Range(
      min: data?['min'] * 1.0,
      max: data?['max'] * 1.0,
      width: data?['width'] * 1.0,
      type: data?['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'min': min,
      'max': max,
      'width': width,
      'type': type,
    };
  }
}
