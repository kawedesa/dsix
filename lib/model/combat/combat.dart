import 'package:dsix/model/combat/ability.dart';
import 'package:dsix/model/combat/action_area.dart';
import 'package:dsix/model/combat/action_info.dart';
import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:flutter/material.dart';
import '../npc/npc.dart';
import '../player/player.dart';
import 'attack.dart';
import 'dart:math' as math;

class Combat {
  ActionArea actionArea = ActionArea();
  ActionInfo actionInfo = ActionInfo.empty();
  Position inputCenter = Position.empty();
  Offset mousePosition = Offset.zero;
  BattleLog battleLog = BattleLog.empty();
  Player? selectedPlayer;
  Npc? selectedNpc;

  void startAttack(Position inputCenter, Position actionCenter, Attack attack,
      Player? selectedPlayer, Npc? selectedNpc) {
    actionInfo.attack = attack;
    actionInfo.actionCenter = actionCenter;
    this.inputCenter = inputCenter;
    setAttacker(selectedPlayer, selectedNpc);
  }

  void startAbility(
      Position inputCenter, Position actionCenter, Ability ability) {
    actionInfo.ability = ability;
    actionInfo.actionCenter = actionCenter;
    this.inputCenter = inputCenter;
  }

  void setAttacker(Player? selectedPlayer, Npc? selectedNpc) {
    if (selectedPlayer != null) {
      this.selectedPlayer = selectedPlayer;
    }

    if (selectedNpc != null) {
      this.selectedNpc = selectedNpc;
    }
  }

  void setMousePosition(Offset position) {
    mousePosition = position;
  }

  void resetAction() {
    inputCenter = Position.empty();
    actionInfo = ActionInfo.empty();
    mousePosition = Offset.zero;
    selectedNpc = null;
    selectedPlayer = null;
    resetArea();
    battleLog.reset();
  }

  void resetArea() {
    actionArea.reset();
  }

  void setActionArea() {
    double angle = math.atan2(mousePosition.dy - inputCenter.dy,
            mousePosition.dx - inputCenter.dx) -
        1.5708;

    double distance = (inputCenter.getDistanceFromPoint(mousePosition)) / 500;

    if (distance > 1) {
      distance = 1;
    }

    actionInfo.angle = angle;
    actionInfo.distance = distance;
    actionArea.setArea(actionInfo);
    battleLog.setAttackInfo(actionInfo);
  }

  void confirmAction(List<Npc> npcs, List<Player> players) {
    battleLog.setPossibleTargets(npcs, players);
    confirmAttack(npcs, players);
    confirmAbility(npcs, players);
    battleLog.addTargets(npcs, players);
    battleLog.newBattleLog();
  }

  void confirmAttack(List<Npc> npcs, List<Player> players) {
    if (actionInfo.attack.name == '') {
      return;
    }
    unloadAttack();
    attackNpcs(npcs, players);
    attackPlayers(players);
    attackerEffects();
  }

  void unloadAttack() {
    if (selectedPlayer != null) {
      selectedPlayer!.unload(actionInfo.attack);
    }

    if (selectedNpc != null) {
      selectedNpc!.unload(actionInfo.attack);
      selectedNpc!.update();
    }
  }

  void attackNpcs(List<Npc> npcs, List<Player> players) {
    for (Npc npc in npcs) {
      if (selectedNpc != null && npc.id == selectedNpc!.id) {
        continue;
      }

      if (npc.life.isDead()) {
        continue;
      }

      if (npc.inActionArea(actionArea.area) == false) {
        continue;
      }

      if (actionInfo.attack.type == 'melee') {
        onHitEffects(npc.effects.onHit);
      }

      List<int> armorAndLifeDamage = npc.receiveAttack(actionInfo.attack);

      if (armorAndLifeDamage[1] > 0) {
        npc.receiveEffects(actionInfo.attack.effects);
        if (actionInfo.attack.effects.contains('knockback')) {
          npc.knockBack(actionInfo.actionCenter);
        }
        npc.onDamageEffects();
      }

      if (npc.life.isDead()) {
        npc.die(players, npcs);
      }

      npc.update();
    }
  }

  void attackPlayers(List<Player> players) {
    for (Player player in players) {
      if (selectedPlayer != null && player.id == selectedPlayer!.id) {
        continue;
      }

      if (player.life.isDead()) {
        continue;
      }

      if (player.inActionArea(actionArea.area) == false) {
        continue;
      }

      if (actionInfo.attack.type == 'melee') {
        onHitEffects(player.effects.onHit);
      }

      List<int> armorAndLifeDamage = player.receiveAttack(actionInfo.attack);

      if (armorAndLifeDamage == [0, 0]) {
        print('armorAndLifeDamage check is used');
        continue;
      }

      if (armorAndLifeDamage[1] > 0) {
        player.receiveEffects(actionInfo.attack.effects);

        if (actionInfo.attack.effects.contains('knockback')) {
          player.knockBack(actionInfo.actionCenter);
        }
      }
      if (player.life.isDead()) {
        player.die();
      }
    }
  }

  void confirmAbility(List<Npc> npcs, List<Player> players) {
    if (actionInfo.ability.name == '') {
      return;
    }
    castAbilityOnNpcs(npcs);
    castAbilityOnPlayers(players);
  }

  void castAbilityOnNpcs(List<Npc> npcs) {
    for (Npc npc in npcs) {
      if (selectedNpc != null && npc.id == selectedNpc!.id) {
        continue;
      }

      if (npc.life.isDead()) {
        continue;
      }

      if (npc.inActionArea(actionArea.area) == false) {
        continue;
      }

      npc.receiveEffects(actionInfo.ability.effects);
      npc.update();
    }
  }

  void castAbilityOnPlayers(List<Player> players) {
    for (Player player in players) {
      if (selectedPlayer != null && player.id == selectedPlayer!.id) {
        continue;
      }

      if (player.life.isDead()) {
        continue;
      }

      if (player.inActionArea(actionArea.area) == false) {
        continue;
      }
      player.receiveEffects(actionInfo.ability.effects);
    }
  }

//EFFECTS
  void onHitEffects(List<String> effects) {
    if (selectedNpc != null) {
      selectedNpc!.receiveEffects(effects);
      selectedNpc!.update();
    }
    if (selectedPlayer != null) {
      selectedPlayer!.receiveEffects(effects);
    }
  }

  void attackerEffects() {
    for (String effect in actionInfo.attack.effects) {
      switch (effect) {
        case 'drain':
          int healAmount = battleLog.targets.length;
          if (selectedNpc != null) {
            selectedNpc!.heal(healAmount);
            selectedNpc!.update();
          }
          if (selectedPlayer != null) {
            selectedPlayer!.heal(healAmount);
          }
          break;

        case 'kickback':
          if (selectedNpc != null) {
            selectedNpc!.knockBack(actionInfo.getKickBackDirection());
            selectedNpc!.update();
          }
          if (selectedPlayer != null) {
            selectedPlayer!.knockBack(actionInfo.getKickBackDirection());
          }

          break;

        case 'explode':
          if (selectedNpc != null) {
            selectedNpc!.delete();
          }

          break;
      }
    }
  }
}
