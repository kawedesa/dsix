import 'package:dsix/model/combat/effect/effect.dart';
import 'package:dsix/model/combat/effect/passive_effects.dart';

class EffectController {
  List<Effect> currentEffects;
  PassiveEffects passiveEffects;
  EffectController(
      {required this.currentEffects, required this.passiveEffects});

  factory EffectController.empty() {
    return EffectController(
      currentEffects: [],
      passiveEffects: PassiveEffects.empty(),
    );
  }

  factory EffectController.fromMap(Map<String, dynamic>? data) {
    List<Effect> getCurrentEffects = [];
    List<dynamic> currentEffectsMap = data?['currentEffects'];
    for (var effect in currentEffectsMap) {
      getCurrentEffects.add(Effect.fromMap(effect));
    }

    return EffectController(
      currentEffects: getCurrentEffects,
      passiveEffects: PassiveEffects.fromMap(data?['passiveEffects']),
    );
  }

  Map<String, dynamic> toMap() {
    var effectsToMap = currentEffects.map((effect) => effect.toMap()).toList();

    return {
      'currentEffects': effectsToMap,
      'passiveEffects': passiveEffects.toMap(),
    };
  }

  bool markEffectToRemove(Effect effect) {
    if (effect.countdown > 0) {
      return false;
    } else {
      return true;
    }
  }

  void removeEffect(Effect effect) {
    currentEffects.remove(effect);
  }

  void reset() {
    currentEffects = [];
  }
}
