import 'package:dsix/model/combat/action_area.dart';
import 'package:dsix/model/combat/attack_info.dart';
import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:flutter/material.dart';
import '../npc/npc.dart';
import '../player/player.dart';
import 'attack.dart';
import 'dart:math' as math;

class Combat {
  ActionArea actionArea = ActionArea();
  AttackInfo attackInfo = AttackInfo.empty();
  Position inputCenter = Position.empty();
  Offset mousePosition = Offset.zero;
  BattleLog battleLog = BattleLog.empty();
  Player? selectedPlayer;
  Npc? selectedNpc;
  int attackerLifeCheck = 0;
  int attackerArmorCheck = 0;

  void startAttack(Position inputCenter, Position actionCenter, Attack attack,
      Player? selectedPlayer, Npc? selectedNpc) {
    attackInfo.attack = attack;
    attackInfo.actionCenter = actionCenter;
    this.inputCenter = inputCenter;
    setAttacker(selectedPlayer, selectedNpc);
  }

  void setAttacker(Player? selectedPlayer, Npc? selectedNpc) {
    if (selectedPlayer != null) {
      this.selectedPlayer = selectedPlayer;
      attackerArmorCheck = selectedPlayer.attributes.defense.tempArmor;
      attackerLifeCheck = selectedPlayer.life.current;
      battleLog.setAttacker(selectedPlayer.id, selectedPlayer.position);
    }

    if (selectedNpc != null) {
      this.selectedNpc = selectedNpc;
      attackerArmorCheck = selectedNpc.attributes.defense.tempArmor;
      attackerLifeCheck = selectedNpc.life.current;
      battleLog.setAttacker(selectedNpc.id.toString(), selectedNpc.position);
    }
  }

  void setMousePosition(Offset position) {
    mousePosition = position;
  }

  void resetAction() {
    inputCenter = Position.empty();
    attackInfo = AttackInfo.empty();
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

    double distance = (inputCenter.getDistanceFromPoint(mousePosition)) / 300;

    if (distance > 1) {
      distance = 1;
    }

    attackInfo.angle = angle;
    attackInfo.distance = distance;
    actionArea.setArea(attackInfo);
    battleLog.setAttackInfo(attackInfo);
  }

  void confirmAttack(List<Npc> npcs, List<Player> players) {
    unloadAttack();
    attackNpcs(npcs);
    attackPlayers(players);
    attackerEffects();
    checkAttacker();
    battleLog.newBattleLog();
    battleLog.reset();
  }

  void unloadAttack() {
    if (selectedPlayer != null) {
      selectedPlayer!.unload(attackInfo.attack);
    }

    if (selectedNpc != null) {
      selectedNpc!.unload(attackInfo.attack);
    }
  }

  void attackNpcs(List<Npc> npcs) {
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

      if (attackInfo.attack.type == 'melee') {
        onBeignHitEffects(npc.effects.onBeignHitEffects);
      }

      int tempArmor = npc.attributes.defense.tempArmor;
      int lifeDamage = 0;

      lifeDamage = npc.receiveAttack(attackInfo.attack);

      int armorDamage = tempArmor - npc.attributes.defense.tempArmor;

      if (lifeDamage < 1 && armorDamage < 1) {
        continue;
      }

      if (lifeDamage > 1) {
        npc.receiveEffects(attackInfo.attack.effects);
        if (attackInfo.attack.effects.contains('knockback')) {
          npc.knockBack(attackInfo.actionCenter);
        }
      }

      battleLog.addTarget(
          npc.id.toString(), npc.position, lifeDamage, armorDamage);

      if (npc.life.isAlive()) {
        continue;
      }
      npc.resetEffects();
      npc.createLoot();
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

      if (attackInfo.attack.type == 'melee') {
        onBeignHitEffects(player.effects.onBeignHitEffects);
      }
      int tempArmor = player.attributes.defense.tempArmor;
      int lifeDamage = 0;

      lifeDamage = player.receiveAttack(attackInfo.attack);

      int armorDamage = tempArmor - player.attributes.defense.tempArmor;

      if (lifeDamage < 1 && armorDamage < 1) {
        continue;
      }

      if (lifeDamage > 1) {
        player.receiveEffects(attackInfo.attack.effects);
        if (attackInfo.attack.effects.contains('knockback')) {
          player.knockBack(attackInfo.actionCenter);
        }
      }

      battleLog.addTarget(
          player.id.toString(), player.position, lifeDamage, armorDamage);

      if (player.life.isAlive()) {
        continue;
      }
      player.resetEffects();
    }
  }

  void onBeignHitEffects(List<String> effects) {
    applyEffectsToSelectedPlayer(effects);
    applyEffectsToSelectedNpc(effects);
  }

  void applyEffectsToSelectedPlayer(List<String> effects) {
    if (selectedPlayer == null) {
      return;
    }

    selectedPlayer!.receiveEffects(effects);
  }

  void applyEffectsToSelectedNpc(List<String> effects) {
    if (selectedNpc == null) {
      return;
    }
    selectedNpc!.receiveEffects(effects);
  }

  void attackerEffects() {
    for (String effect in attackInfo.attack.effects) {
      switch (effect) {
        case 'drain':
          int healAmount = battleLog.targets.length;
          if (selectedNpc != null) {
            selectedNpc!.heal(healAmount);
          }
          if (selectedPlayer != null) {
            selectedPlayer!.heal(healAmount);
          }
          break;

        case 'kickback':
          if (selectedNpc != null) {
            selectedNpc!.knockBack(attackInfo.getKickBackDirection());
          }
          if (selectedPlayer != null) {
            selectedPlayer!.knockBack(attackInfo.getKickBackDirection());
          }

          break;
      }
    }
  }

  void checkAttacker() {
    if (selectedNpc != null) {
      int lifeCheck = attackerLifeCheck - selectedNpc!.life.current;
      int armorCheck =
          attackerArmorCheck - selectedNpc!.attributes.defense.tempArmor;

      if (lifeCheck > 0 || armorCheck > 0) {
        battleLog.addTarget(selectedNpc!.id.toString(), selectedNpc!.position,
            lifeCheck, armorCheck);
      }
    }

    if (selectedPlayer != null) {
      int lifeCheck = attackerLifeCheck - selectedPlayer!.life.current;
      int armorCheck =
          attackerArmorCheck - selectedPlayer!.attributes.defense.tempArmor;

      if (lifeCheck > 0 || armorCheck > 0) {
        battleLog.addTarget(selectedPlayer!.id.toString(),
            selectedPlayer!.position, lifeCheck, armorCheck);
      }
    }
  }
}
