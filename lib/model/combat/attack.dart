import 'package:dsix/model/combat/effect.dart';
import 'package:dsix/model/combat/range.dart';
import 'damage.dart';

class Attack {
  String name;
  Damage damage;
  Range range;
  List<Effect> onHitEffects;

  Attack(
      {required this.name,
      required this.damage,
      required this.range,
      required this.onHitEffects});

  factory Attack.empty() {
    return Attack(
      name: 'punch',
      damage: Damage.empty(),
      range: Range(min: 6, max: 0, width: 4, shape: 'circle'),
      onHitEffects: [],
    );
  }

  factory Attack.fromMap(Map<String, dynamic>? data) {
    List<Effect> getOnHitEffects = [];
    List<dynamic> getOnHitEffectsMap = data?['onHitEffects'];
    for (var onHitEffect in getOnHitEffectsMap) {
      getOnHitEffects.add(Effect.fromMap(onHitEffect));
    }

    return Attack(
        name: data?['name'],
        damage: Damage.fromMap(data?['damage']),
        range: Range.fromMap(data?['range']),
        onHitEffects: []);
  }

  Map<String, dynamic> toMap() {
    var onHitEffectsToMap =
        onHitEffects.map((onHitEffect) => onHitEffect.toMap()).toList();

    return {
      'name': name,
      'damage': damage.toMap(),
      'range': range.toMap(),
      'onHitEffects': onHitEffectsToMap,
    };
  }
}
