import 'package:dsix/model/combat/range.dart';
import 'damage.dart';

class Attack {
  String name;
  Damage damage;
  Range range;
  List<String> effects;

  Attack(
      {required this.name,
      required this.damage,
      required this.range,
      required this.effects});

  factory Attack.empty() {
    return Attack(
      name: 'punch',
      damage: Damage.empty(),
      range: Range(min: 6, max: 0, width: 4, shape: 'circle'),
      effects: [],
    );
  }

  factory Attack.fromMap(Map<String, dynamic>? data) {
    List<String> getEffects = [];
    List<dynamic> effectsMap = data?['effects'];
    for (var effect in effectsMap) {
      getEffects.add(effect);
    }

    return Attack(
        name: data?['name'],
        damage: Damage.fromMap(data?['damage']),
        range: Range.fromMap(data?['range']),
        effects: getEffects);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'damage': damage.toMap(),
      'range': range.toMap(),
      'effects': effects,
    };
  }
}
