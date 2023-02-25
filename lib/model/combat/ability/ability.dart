import '../range.dart';

class Ability {
  String name;
  Range range;
  Ability({required this.name, required this.range});

  factory Ability.empty() {
    return Ability(name: '', range: Range.empty());
  }

  factory Ability.fromMap(Map<String, dynamic>? data) {
    return Ability(
      name: data?['name'],
      range: Range.fromMap(data?['range']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'range': range.toMap(),
    };
  }
}
