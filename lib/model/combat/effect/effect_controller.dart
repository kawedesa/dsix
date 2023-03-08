import 'package:dsix/model/combat/effect/effect.dart';
import 'package:dsix/model/combat/effect/passive_effects.dart';
import 'package:dsix/shared/app_exceptions.dart';

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

  void applyNewEffect(Effect effect) {
    switch (effect.name) {
      case 'poison':
        currentEffects.add(effect);
        break;
      case 'thorn':
        throw TakeDamageException(effect.value);
      case 'bleed':
        currentEffects.add(effect);
        break;

      case 'tempArmor':
        for (Effect effect in currentEffects) {
          if (effect.name == 'tempArmor') {
            currentEffects.remove(effect);
          }
        }
        currentEffects.add(effect);
        break;
    }
  }

  void checkEffects() {
    List<Effect> effectsToRemove = [];

    for (Effect effect in currentEffects) {
      triggerEffects(effect);
      if (markEffectToRemove(effect)) {
        effectsToRemove.add(effect);
      }
    }

    for (Effect effect in effectsToRemove) {
      removeEffect(effect);
    }
  }

  void triggerEffects(Effect effect) {
    switch (effect.name) {
      case 'poison':
        effect.countdown--;

        throw TakeDamageException(effect.value);
      case 'bleed':
        effect.countdown--;
        throw TakeDamageException(effect.value);
      case 'tempArmor':
        currentEffects.remove(effect);
    }
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
}
