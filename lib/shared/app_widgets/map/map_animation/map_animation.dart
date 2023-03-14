import 'package:dsix/model/combat/action_area.dart';
import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/model/game/turn.dart';
import 'package:flutter/material.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

import 'attack_animation.dart';
import 'damage_animation.dart';
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
    return TransparentPointer(
        transparent: true,
        child: Stack(
          children: turnAnimation,
        ));
  }

  //BATTLE ANIMATIONS
  List<Widget> attackAnimations = [];
  List<Widget> damageAnimations = [];
  int currentLog = 0;

  void checkBattleLog(List<BattleLog> battleLog) {
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

    addAttackAnimation(battleLog.last.attackInfo);

    addDamageAnimation(battleLog.last.targets);

    currentLog = battleLog.last.id;
  }

  void addAttackAnimation(AttackInfo attackInfo) {
    Path attackArea = ActionArea().getArea(attackInfo);

    attackAnimations.add(AttackAnimation(attackArea: attackArea));
  }

  void addDamageAnimation(List<Target> targets) {
    for (Target target in targets) {
      damageAnimations.add(
          DamageAnimation(damage: target.damage, position: target.position));
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

  Widget displayDamageAnimations() {
    return TransparentPointer(
      transparent: true,
      child: Stack(
        children: damageAnimations,
      ),
    );
  }
}