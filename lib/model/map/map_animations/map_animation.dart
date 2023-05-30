import 'dart:async';

import 'package:dsix/model/combat/action_area.dart';
import 'package:dsix/model/combat/action_info.dart';
import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/model/game/turn.dart';
import 'package:dsix/model/map/map_animations/action_area_animation.dart';
import 'package:dsix/model/map/map_animations/aura_animation.dart';
import 'package:dsix/model/map/map_animations/gold_animation.dart';
import 'package:dsix/model/map/map_animations/hit_animation.dart';
import 'package:flutter/material.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

import 'armor_damage_animation.dart';
import 'attack_animation.dart';
import 'life_damage_animation.dart';
import 'turn_animation.dart';

class MapAnimation {
  //TURN ANIMATION
  List<Widget> turnAnimation = [];
  int currentTurn = 0;

  void checkPlayerTurn(Turn turn) {
    if (turn.count == currentTurn) {
      return;
    }
    if (turn.currentTurn != 'player') {
      return;
    }

    currentTurn = turn.count;
    turnAnimation.add(const TurnAnimation());
  }

  void checkNpcTurn(Turn turn) {
    if (turn.count == currentTurn) {
      return;
    }
    if (turn.currentTurn != 'npc') {
      return;
    }
    currentTurn = turn.count;
    turnAnimation.add(const TurnAnimation());
  }

  Widget displayTurnAnimations() {
    return Align(
      alignment: const Alignment(0, -0.75),
      child: TransparentPointer(
          transparent: true,
          child: Stack(
            children: turnAnimation,
          )),
    );
  }

  //BATTLE ANIMATIONS
  List<Widget> actionAreaAnimations = [];
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

    if (currentLog == 0) {
      currentLog = battleLog.last.id;
      return;
    }

    addActionAreaAnimation(battleLog.last.attackInfo);
    addAuraAnimation(battleLog.last.auras);
    addAttackAnimation(battleLog.last.attackInfo);
    addHitAnimation(battleLog.last.attackInfo, battleLog.last.targets, refresh);
    addLifeDamageAnimation(battleLog.last.targets, refresh);
    addArmorDamageAnimation(battleLog.last.targets, refresh);
    addGoldAnimation(battleLog.last.targets, refresh);
    currentLog = battleLog.last.id;
  }

  void addActionAreaAnimation(ActionInfo attackInfo) {
    actionAreaAnimations.add(ActionAreaAnimation(attackInfo: attackInfo));
  }

  void addAttackAnimation(ActionInfo attackInfo) {
    attackAnimations.add(AttackAnimation(attackInfo: attackInfo));
  }

  void addHitAnimation(
      ActionInfo attackInfo, List<Target> targets, Function refresh) {
    if (attackInfo == ActionInfo.empty()) {
      return;
    }
    Timer(const Duration(milliseconds: 50), () {
      targetAnimations.add(HitAnimation(targets: targets));
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

  Widget displayActionAreaAnimations() {
    return TransparentPointer(
      transparent: true,
      child: Stack(
        children: actionAreaAnimations,
      ),
    );
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
