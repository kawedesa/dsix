import 'package:dsix/model/effect/effect.dart';

class EffectController {
  List<Effect> currentEffects;
  List<String> onBeignHitEffects;
  List<String> onDeathEffects;

  EffectController({
    required this.currentEffects,
    required this.onBeignHitEffects,
    required this.onDeathEffects,
  });

  factory EffectController.empty() {
    return EffectController(
      currentEffects: [],
      onBeignHitEffects: [],
      onDeathEffects: [],
    );
  }

  factory EffectController.fromMap(Map<String, dynamic>? data) {
    List<Effect> getCurrentEffects = [];
    List<dynamic> currentEffectsMap = data?['currentEffects'];
    for (var effect in currentEffectsMap) {
      getCurrentEffects.add(Effect.fromMap(effect));
    }

    List<String> getOnBeignHitEffects = [];
    List<dynamic> onBeignHitEffectsMap = data?['onBeignHitEffects'];
    for (var effect in onBeignHitEffectsMap) {
      getOnBeignHitEffects.add(effect);
    }

    List<String> getOnDeathEffects = [];
    List<dynamic> onDeathEffectsMap = data?['onDeathEffects'];
    for (var effect in onDeathEffectsMap) {
      getOnDeathEffects.add(effect);
    }

    return EffectController(
      currentEffects: getCurrentEffects,
      onBeignHitEffects: getOnBeignHitEffects,
      onDeathEffects: getOnDeathEffects,
    );
  }

  Map<String, dynamic> toMap() {
    var effectsToMap = currentEffects.map((effect) => effect.toMap()).toList();

    return {
      'currentEffects': effectsToMap,
      'onBeignHitEffects': onBeignHitEffects,
      'onDeathEffects': onDeathEffects,
    };
  }

  void resetCurrentEffects() {
    for (Effect effect in currentEffects) {
      effect.reset();
    }
  }

  bool markEffectToRemove(Effect effect) {
    if (effect.countdown > 0) {
      return false;
    } else {
      return true;
    }
  }

  void removeEffect(String effect) {
    for (Effect checkEffect in currentEffects) {
      if (checkEffect.name == effect) {
        currentEffects.remove(checkEffect);
      }
    }
  }

  bool isVulnerable() {
    bool check = false;
    for (Effect effect in currentEffects) {
      if (effect.name == 'vulnerable') {
        check = true;
      }
    }
    return check;
  }

  bool isWeaken() {
    bool check = false;
    for (Effect effect in currentEffects) {
      if (effect.name == 'weaken') {
        check = true;
      }
    }
    return check;
  }
}
