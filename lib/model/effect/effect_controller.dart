import 'package:dsix/model/effect/effect.dart';

class EffectController {
  List<Effect> currentEffects;
  List<String> auras;
  List<String> onHit;
  List<String> onDamage;
  List<String> onDeath;

  EffectController({
    required this.currentEffects,
    required this.auras,
    required this.onHit,
    required this.onDamage,
    required this.onDeath,
  });

  factory EffectController.empty() {
    return EffectController(
      currentEffects: [],
      auras: [],
      onHit: [],
      onDamage: [],
      onDeath: [],
    );
  }

  factory EffectController.fromMap(Map<String, dynamic>? data) {
    List<Effect> getCurrentEffects = [];
    List<dynamic> currentEffectsMap = data?['currentEffects'];
    for (var effect in currentEffectsMap) {
      getCurrentEffects.add(Effect.fromMap(effect));
    }

    List<String> getAuras = [];
    List<dynamic> aurasMap = data?['auras'];
    for (var aura in aurasMap) {
      getAuras.add(aura);
    }

    List<String> getOnHit = [];
    List<dynamic> onHitMap = data?['onHit'];
    for (var effect in onHitMap) {
      getOnHit.add(effect);
    }

    List<String> getOnDamage = [];
    List<dynamic> onDamageMap = data?['onDamage'];
    for (var effect in onDamageMap) {
      getOnDamage.add(effect);
    }

    List<String> getOnDeath = [];
    List<dynamic> onDeathMap = data?['onDeath'];
    for (var effect in onDeathMap) {
      getOnDeath.add(effect);
    }

    return EffectController(
      currentEffects: getCurrentEffects,
      auras: getAuras,
      onHit: getOnHit,
      onDamage: getOnDamage,
      onDeath: getOnDeath,
    );
  }

  Map<String, dynamic> toMap() {
    var effectsToMap = currentEffects.map((effect) => effect.toMap()).toList();

    return {
      'currentEffects': effectsToMap,
      'auras': auras,
      'onHit': onHit,
      'onDamage': onDamage,
      'onDeath': onDeath,
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
