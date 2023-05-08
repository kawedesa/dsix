import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/combat/combat.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/prop/prop.dart';
import 'package:dsix/model/tile/tile.dart';
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
  MapInfo mapInfo = MapInfo();

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
    prop = null;
    tile = null;
  }

  bool somethingIsSelected() {
    if (npc == null && building == null && prop == null) {
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
    newNpc.setId();
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
  // void updateBuilding(List<Building> buildings) {
  //   if (building == null) {
  //     return;
  //   }

  //   for (Building building in buildings) {
  //     if (this.building!.id == building.id) {
  //       this.building = building;
  //     }
  //   }
  // }

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
    newBuilding.setId();
    newBuilding.position.dx += 5;
    newBuilding.set();
    building = newBuilding;
  }

  void createBuilding() {
    building!.position = placeHere;
    building!.set();
  }

  //CHEST
  Prop? prop;

  void selectProp(Prop prop) {
    this.prop = prop;
  }

  bool checkSelectedProp(int id) {
    if (prop == null) {
      return false;
    }

    if (prop!.id == id) {
      return true;
    } else {
      return false;
    }
  }

  void duplicateProp() {
    Prop newProp = prop!;
    newProp.setId();
    newProp.position.dx += 5;
    int lootValue = newProp.getLootValue();
    newProp.loot = [];
    newProp.createLoot(lootValue);
    newProp.set();
    prop = newProp;
  }

  void createProp() {
    prop!.position = placeHere;
    prop!.set();
  }

  //TILE
  Tile? tile;

  void selectTile(Tile tile) {
    this.tile = tile;
  }

  bool checkSelectedTile(int id) {
    if (tile == null) {
      return false;
    }

    if (tile!.id == id) {
      return true;
    } else {
      return false;
    }
  }

  void putTileOnTop() {
    Tile newTile = tile!;
    tile!.delete();
    newTile.setId();
    newTile.set();
  }

  void createTile() {
    tile!.position = placeHere;
    tile!.set();
  }
}
