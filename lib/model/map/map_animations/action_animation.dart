import 'dart:async';
import 'package:dsix/model/combat/action_info.dart';
import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/model/map/map_animations/aura_animation.dart';
import 'package:dsix/model/map/map_animations/gold_animation.dart';
import 'package:dsix/model/map/map_animations/hit_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_pointer/transparent_pointer.dart';
import 'armor_damage_animation.dart';
import 'attack_animation.dart';
import 'life_damage_animation.dart';

class ActionAnimation extends StatefulWidget {
  const ActionAnimation({super.key});

  @override
  State<ActionAnimation> createState() => _ActionAnimationState();
}

class _ActionAnimationState extends State<ActionAnimation> {
  final MapAnimationController _actionAnimationController =
      MapAnimationController();

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final battleLog = Provider.of<List<BattleLog>>(context);

    _actionAnimationController.checkBattleLog(battleLog, refresh);

    return Stack(
      children: [
        _actionAnimationController.displayAttackAnimations(),
        _actionAnimationController.displayTargetAnimations(),
        _actionAnimationController.displayAuraAnimations(),
      ],
    );
  }
}

class MapAnimationController {
  //BATTLE ANIMATIONS
  List<Widget> attackAnimations = [];
  List<Widget> auraAnimations = [];
  List<Widget> targetAnimations = [];
  int currentLog = 0;

  void checkBattleLog(List<BattleLog> battleLog, Function refresh) {
    if (battleLog.isEmpty) {
      return;
    }
    if (currentLog == battleLog.last.id) {
      return;
    }

    addAuraAnimation(battleLog.last.auras);
    addAttackAnimation(battleLog.last.attackInfo);
    addHitAnimation(battleLog.last.attackInfo, battleLog.last.targets, refresh);
    addLifeDamageAnimation(battleLog.last.targets, refresh);
    addArmorDamageAnimation(battleLog.last.targets, refresh);
    addGoldAnimation(battleLog.last.targets, refresh);
    currentLog = battleLog.last.id;
  }

  void addAttackAnimation(ActionInfo attackInfo) {
    attackAnimations.add(AttackAnimation(attackInfo: attackInfo));
  }

  void addHitAnimation(
      ActionInfo attackInfo, List<Target> targets, Function refresh) {
    Timer(const Duration(milliseconds: 50), () {
      targetAnimations
          .add(HitAnimation(actionInfo: attackInfo, targets: targets));
      refresh();
    });
  }

  void addAuraAnimation(List<AuraInfo> info) {
    for (AuraInfo auraInfo in info) {
      auraAnimations.add(AuraAnimation(
        position: auraInfo.position,
        aura: auraInfo.aura,
      ));
    }
  }

  void addLifeDamageAnimation(List<Target> targets, Function refresh) {
    for (Target target in targets) {
      if (target.life == 0) {
        continue;
      }
      Timer(const Duration(milliseconds: 400), () {
        targetAnimations.add(LifeDamageAnimation(
            damage: target.life, position: target.position));
        refresh();
      });
    }
  }

  void addArmorDamageAnimation(List<Target> targets, Function refresh) {
    for (Target target in targets) {
      if (target.armor == 0) {
        continue;
      }
      Timer(const Duration(milliseconds: 400), () {
        targetAnimations.add(ArmorDamageAnimation(
            damage: target.armor, position: target.position));
        refresh();
      });
    }
  }

  void addGoldAnimation(List<Target> targets, Function refresh) {
    for (Target target in targets) {
      if (target.gold == 0) {
        continue;
      }
      Timer(const Duration(milliseconds: 400), () {
        targetAnimations
            .add(GoldAnimation(amount: target.gold, position: target.position));
        refresh();
      });
    }
  }

  Widget displayAttackAnimations() {
    return TransparentPointer(
      transparent: true,
      child: Stack(
        children: attackAnimations,
      ),
    );
  }

  Widget displayAuraAnimations() {
    return TransparentPointer(
      transparent: true,
      child: Stack(
        children: auraAnimations,
      ),
    );
  }

  Widget displayTargetAnimations() {
    return TransparentPointer(
      transparent: true,
      child: Stack(
        children: targetAnimations,
      ),
    );
  }
}
