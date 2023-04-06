import 'package:dsix/model/combat/range.dart';
import 'damage.dart';

class Attack {
  String name;
  String type;
  Damage damage;
  Range range;
  List<String> effects;
  bool isLoaded;
  bool needsReload;

  Attack(
      {required this.name,
      required this.type,
      required this.damage,
      required this.range,
      required this.effects,
      required this.isLoaded,
      required this.needsReload});

  factory Attack.empty() {
    return Attack(
      name: 'punch',
      type: 'melee',
      damage: Damage.empty(),
      range: Range(min: 6, max: 0, width: 4, shape: 'circle'),
      effects: [],
      isLoaded: false,
      needsReload: false,
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
      type: data?['type'],
      damage: Damage.fromMap(data?['damage']),
      range: Range.fromMap(data?['range']),
      effects: getEffects,
      isLoaded: data?['isLoaded'],
      needsReload: data?['needsReload'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'damage': damage.toMap(),
      'range': range.toMap(),
      'effects': effects,
      'isLoaded': isLoaded,
      'needsReload': needsReload,
    };
  }

  void reload() {
    isLoaded = true;
  }

  void unload() {
    isLoaded = false;
  }
}
