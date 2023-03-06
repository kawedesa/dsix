import 'package:dsix/model/combat/effect/effect.dart';

class PassiveEffects {
  Effect onBeingHitEffect;
  Effect afterAttackEffect;
  PassiveEffects({
    required this.onBeingHitEffect,
    required this.afterAttackEffect,
  });

  factory PassiveEffects.empty() {
    return PassiveEffects(
      onBeingHitEffect: Effect.empty(),
      afterAttackEffect: Effect.empty(),
    );
  }

  factory PassiveEffects.fromMap(Map<String, dynamic>? data) {
    return PassiveEffects(
      onBeingHitEffect: Effect.fromMap(data?['onBeingHitEffect']),
      afterAttackEffect: Effect.fromMap(data?['afterAttackEffect']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'onBeingHitEffect': onBeingHitEffect.toMap(),
      'afterAttackEffect': afterAttackEffect.toMap(),
    };
  }
}
