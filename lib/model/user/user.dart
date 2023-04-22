import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/combat/combat.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/chest/chest.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/model/map/map_info.dart';
import 'package:flutter/material.dart';

class User {
  Player player = Player.empty();
  Color color = Colors.transparent;
  Color lightColor = Colors.transparent;
  Color darkColor = Colors.transparent;

  Npc? npc;
  String npcMode = 'stand';

  void selectCreator() {
    color = AppColors.uiColor;
    lightColor = AppColors.uiColorLight;
    darkColor = AppColors.uiColorDark;
  }

  //MAPINFO
  MapInfo mapInfo = MapInfo.empty();

  //COMBAT
  Combat combat = Combat();

  //PLAYER
  void selectPlayer(Player player) {
    this.player = player;

    switch (player.id) {
      case 'purple':
        color = AppColors.purple;
        lightColor = AppColors.purpleLight;
        darkColor = AppColors.purpleDark;
        break;
      case 'pink':
        color = AppColors.pink;
        lightColor = AppColors.pinkLight;
        darkColor = AppColors.pinkDark;
        break;
      case 'yellow':
        color = AppColors.yellow;
        lightColor = AppColors.yellowLight;
        darkColor = AppColors.yellowDark;
        break;
      case 'green':
        color = AppColors.green;
        lightColor = AppColors.greenLight;
        darkColor = AppColors.greenDark;
        break;
      case 'blue':
        color = AppColors.blue;
        lightColor = AppColors.blueLight;
        darkColor = AppColors.blueDark;
        break;
    }
  }

  void updatePlayer(List<Player> players) {
    for (Player player in players) {
      if (player.id == this.player.id) {
        this.player = player;
      }
    }
  }

  void setPlayerMode(String turn) {
    if (turn == 'npc') {
      playerWaitMode();
    }

    if (turn == 'player') {
      if (playerMode == 'wait') {
        playerMode = 'stand';
      }
    }
  }

  String playerMode = 'stand';

  void playerActionMode() {
    playerMode = 'action';
  }

  void playerStandMode() {
    playerMode = 'stand';
  }

  void playerWaitMode() {
    playerMode = 'wait';
  }

  //SELECTION

  void deselect() {
    npc = null;
    building = null;
    chest = null;
  }

  bool somethingIsSelected() {
    if (npc == null && building == null) {
      return false;
    } else {
      return true;
    }
  }

  //PLACE SOMETHING ON SCREEN
  String placingSomething = 'false';
  Position placeHere = Position.empty();

  void setPlaceHere(Offset mouseOffset) {
    placeHere = mapInfo.getMousePosition(mouseOffset);
  }

  void resetPlacing() {
    placeHere = Position.empty();
    placingSomething = 'false';
  }

  void startPlacingSomething(String something) {
    placingSomething = something;
    placeHere = Position.empty();
  }

  //NPC
  void updateNpc(List<Npc> npcs) {
    if (npc == null) {
      return;
    }

    for (Npc npc in npcs) {
      if (npc.id == this.npc!.id) {
        this.npc = npc;
      }
    }
  }

  bool checkSelectedNpc(int id) {
    if (npc == null) {
      return false;
    }

    if (id == npc!.id) {
      return true;
    } else {
      return false;
    }
  }

  void setNpcMode(String turn) {
    if (turn == 'player') {
      npcWaitMode();
    }

    if (turn == 'npc') {
      if (npcMode == 'wait') {
        npcMode = 'stand';
      }
    }
  }

  void npcActionMode() {
    npcMode = 'action';
  }

  void npcStandMode() {
    npcMode = 'stand';
  }

  void npcWaitMode() {
    npcMode = 'wait';
  }

  void selectNpc(Npc npc) {
    if (npc.life.isDead()) {
      return;
    }
    this.npc = npc;
  }

  void duplicateNpc() {
    Npc newNpc = npc!;
    newNpc.id = DateTime.now().millisecondsSinceEpoch;
    newNpc.position.dx += 5;
    newNpc.set();
    npc = newNpc;
  }

  void createNpc() {
    npc!.position = placeHere;
    npc!.set();
  }

  //BUILDING

  Building? building;

  void updateBuilding(List<Building> buildings) {
    if (building == null) {
      return;
    }

    for (Building building in buildings) {
      if (this.building!.id == building.id) {
        this.building = building;
      }
    }
  }

  void selectBuilding(Building building) {
    this.building = building;
  }

  bool checkSelectedBuilding(int id) {
    if (building == null) {
      return false;
    }

    if (building!.id == id) {
      return true;
    } else {
      return false;
    }
  }

  void duplicateBuilding() {
    Building newBuilding = building!;
    newBuilding.id = DateTime.now().millisecondsSinceEpoch;
    newBuilding.position.dx += 5;
    newBuilding.set();
    building = newBuilding;
  }

  void createBuilding() {
    building!.position = placeHere;
    building!.set();
  }

  //PROPS
  Chest? chest;

  void updateChest(List<Chest> chests) {
    if (chest == null) {
      return;
    }

    for (Chest chest in chests) {
      if (this.chest!.id == chest.id) {
        this.chest = chest;
      }
    }
  }

  void selectChest(Chest chest) {
    this.chest = chest;
  }

  bool checkSelectedChest(int id) {
    if (chest == null) {
      return false;
    }

    if (chest!.id == id) {
      return true;
    } else {
      return false;
    }
  }

  void duplicateChest() {
    Chest newChest = chest!;
    newChest.id = DateTime.now().millisecondsSinceEpoch;
    newChest.position.dx += 5;
    int lootValue = newChest.getLootValue();
    newChest.loot = [];
    newChest.createLoot(lootValue);
    newChest.set();
    chest = newChest;
  }

  void createChest() {
    chest!.position = placeHere;
    chest!.set();
  }
}
