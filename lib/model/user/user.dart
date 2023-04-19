import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/combat/combat.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/prop/prop.dart';
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
    prop = null;
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
    placeHere = Position(
        dx: mouseOffset.dx / mapInfo.minZoom - mapInfo.getCanvasPosition().dx,
        dy: mouseOffset.dy / mapInfo.minZoom -
            mapInfo.getCanvasPosition().dy -
            50 / mapInfo.minZoom,
        tile: '');
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
    npc!.changePosition(placeHere);
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
    building!.changePosition(placeHere);
    building!.set();
  }

  //PROPS
  Prop? prop;

  void updateProp(List<Prop> props) {
    if (prop == null) {
      return;
    }

    for (Prop prop in props) {
      if (this.prop!.id == prop.id) {
        this.prop = prop;
      }
    }
  }

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
    newProp.id = DateTime.now().millisecondsSinceEpoch;
    newProp.position.dx += 5;
    newProp.set();
    prop = newProp;
  }

  void createProp() {
    prop!.changePosition(placeHere);
    prop!.set();
  }
}