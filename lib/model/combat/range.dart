class Range {
  double min;
  double max;
  double width;
  String shape;
  Range({
    required this.min,
    required this.max,
    required this.width,
    required this.shape,
  });

  factory Range.empty() {
    return Range(
      min: 0,
      max: 0,
      width: 0,
      shape: 'empty',
    );
  }

  factory Range.fromMap(Map<String, dynamic>? data) {
    return Range(
      min: data?['min'] * 1.0,
      max: data?['max'] * 1.0,
      width: data?['width'] * 1.0,
      shape: data?['shape'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'min': min,
      'max': max,
      'width': width,
      'shape': shape,
    };
  }
}
