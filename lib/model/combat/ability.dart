import 'package:dsix/model/combat/range.dart';

class Ability {
  String name;
  Range range;
  int cooldown;
  int cooldownCount;
  List<String> effects;

  Ability({
    required this.name,
    required this.range,
    required this.cooldown,
    required this.cooldownCount,
    required this.effects,
  });

  factory Ability.empty() {
    return Ability(
      name: '',
      range: Range.empty(),
      cooldown: 0,
      cooldownCount: 0,
      effects: [],
    );
  }

  factory Ability.fromMap(Map<String, dynamic>? data) {
    List<String> getEffects = [];
    List<dynamic> effectsMap = data?['effects'];
    for (var effect in effectsMap) {
      getEffects.add(effect);
    }

    return Ability(
      name: data?['name'],
      range: Range.fromMap(data?['range']),
      cooldown: data?['cooldown'],
      cooldownCount: data?['cooldownCount'],
      effects: getEffects,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'range': range.toMap(),
      'cooldown': cooldown,
      'cooldownCount': cooldownCount,
      'effects': effects,
    };
  }
}
