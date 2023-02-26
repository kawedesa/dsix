import 'package:dsix/model/combat/range.dart';
import 'damage.dart';

class Attack {
  String name;
  Damage damage;
  Range range;

  Attack({required this.name, required this.damage, required this.range});

  factory Attack.empty() {
    return Attack(
      name: 'punch',
      damage: Damage.empty(),
      range: Range(min: 5, max: 15, width: 10),
    );
  }

  factory Attack.fromMap(Map<String, dynamic>? data) {
    return Attack(
      name: data?['name'],
      damage: Damage.fromMap(data?['damage']),
      range: Range.fromMap(data?['range']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'damage': damage.toMap(),
      'range': range.toMap(),
    };
  }
}
