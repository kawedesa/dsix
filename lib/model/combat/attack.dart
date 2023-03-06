import 'package:dsix/model/combat/effect/effect.dart';
import 'package:dsix/model/combat/range.dart';
import 'damage.dart';

class Attack {
  String name;
  Damage damage;
  Range range;
  Effect onHitEffect;

  Attack(
      {required this.name,
      required this.damage,
      required this.range,
      required this.onHitEffect});

  factory Attack.empty() {
    return Attack(
      name: 'punch',
      damage: Damage.empty(),
      range: Range(min: 6, max: 0, width: 4, shape: 'circle'),
      onHitEffect: Effect.empty(),
    );
  }

  factory Attack.fromMap(Map<String, dynamic>? data) {
    return Attack(
        name: data?['name'],
        damage: Damage.fromMap(data?['damage']),
        range: Range.fromMap(data?['range']),
        onHitEffect: Effect.fromMap(data?['onHitEffect']));
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'damage': damage.toMap(),
      'range': range.toMap(),
      'onHitEffect': onHitEffect.toMap(),
    };
  }
}
