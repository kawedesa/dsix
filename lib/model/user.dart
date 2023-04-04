import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/combat/combat.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_widgets/map/map_info.dart';
import 'package:flutter/material.dart';

class User {
  Player player = Player.empty();
  Color color = Colors.transparent;
  Color lightColor = Colors.transparent;
  Color darkColor = Colors.transparent;

  void selectCreator() {
    color = AppColors.uiColor;
    lightColor = AppColors.uiColorLight;
    darkColor = AppColors.uiColorDark;
  }

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

  //PLACE SOMETHING ON SCREEN
  String placingSomething = 'false';
  Position placeHere = Position.empty();

  void setPlaceHere(Offset mouseOffset, MapInfo mapInfo) {
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

  void startPlacingBuilding() {
    placingSomething = 'building';
    placeHere = Position.empty();
  }

  void startPlacingNpc() {
    placingSomething = 'npc';
    placeHere = Position.empty();
  }

  //NPC

  Npc? selectedNpc;

  void updateSelectedNpc(List<Npc> npcs) {
    if (selectedNpc == null) {
      return;
    }

    for (Npc npc in npcs) {
      if (selectedNpc!.id == npc.id) {
        selectedNpc = npc;
      }
    }
  }

  void selectNpc(Npc npc) {
    if (npc.life.isDead()) {
      selectedNpc = null;
      return;
    }
    selectedNpc = npc;
  }

  void deselect() {
    selectedNpc = null;
    selectedBuilding = null;
  }

  bool somethingIsSelected() {
    if (selectedNpc == null && selectedBuilding == null) {
      return false;
    } else {
      return true;
    }
  }

  void duplicateNpc() {
    Npc newNpc = selectedNpc!;
    newNpc.id = DateTime.now().millisecondsSinceEpoch;
    newNpc.position.dx += 5;
    newNpc.set();
    selectedNpc = newNpc;
  }

  void createNpc() {
    selectedNpc!.changePosition(placeHere);
    selectedNpc!.set();
  }

  //BUILDING

  Building? selectedBuilding;

  void updateSelectedBuilding(List<Building> buildings) {
    if (selectedBuilding == null) {
      return;
    }

    for (Building building in buildings) {
      if (selectedBuilding!.id == building.id) {
        selectedBuilding = building;
      }
    }
  }

  void selectBuilding(Building building) {
    selectedBuilding = building;
  }

  void duplicateBuilding() {
    Building newBuilding = selectedBuilding!;
    newBuilding.id = DateTime.now().millisecondsSinceEpoch;
    newBuilding.position.dx += 5;
    newBuilding.set();
    selectedBuilding = newBuilding;
  }

  void createBuilding() {
    selectedBuilding!.changePosition(placeHere);
    selectedBuilding!.set();
  }
}
