import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/shared/app_widgets/sprite/spawner_sprite.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/view/player/player_map/widgets/pop_up_menu.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../model/combat/combat.dart';
import '../../../model/combat/position.dart';
import '../../../model/npc/npc.dart';
import '../../../shared/app_widgets/sprite/npc_sprite.dart';
import '../../../shared/app_widgets/sprite/player_sprite.dart';

class PlayerMapVM {
  int mapSize = 320;
  double minZoom = 8;
  double maxZoom = 16;
  TransformationController? canvasController;
  Combat combat = Combat();

  TransformationController createCanvasController(
      context, Position playerPosition) {
    updateMinZoom(context);

    double dxCanvas =
        playerPosition.dx * minZoom - MediaQuery.of(context).size.width / 2;
    double dyCanvas = playerPosition.dy * minZoom -
        MediaQuery.of(context).size.height * 0.8 / 2;

    if (dxCanvas < 0) {
      dxCanvas = 0;
    }
    if (dxCanvas > mapSize * minZoom - MediaQuery.of(context).size.width) {
      dxCanvas = mapSize * minZoom - MediaQuery.of(context).size.width;
    }
    if (dyCanvas < 0) {
      dyCanvas = 0;
    }
    if (dyCanvas >
        mapSize * minZoom - MediaQuery.of(context).size.height * 0.9) {
      dyCanvas = mapSize * minZoom - MediaQuery.of(context).size.height * 0.9;
    }

    canvasController ??= TransformationController(Matrix4(minZoom, 0, 0, 0, 0,
        minZoom, 0, 0, 0, 0, minZoom, 0, -dxCanvas, -dyCanvas, 0, 1));

    return canvasController!;
  }

  void updateMinZoom(context) {
    minZoom = 2 + AppLayout.longest(context) * 0.0025;
  }

  List<SpawnerSprite> createSpawnerSprites(List<Spawner> spawners) {
    List<SpawnerSprite> spawnerSprites = [];

    for (Spawner spawner in spawners) {
      spawnerSprites.add(SpawnerSprite(
        spawner: spawner,
      ));
    }

    return spawnerSprites;
  }

  List<NpcSprite> createNpcSprites(List<Npc> npcs) {
    List<NpcSprite> npcSprites = [];

    for (Npc npc in npcs) {
      npcSprites.add(NpcSprite(
        npc: npc,
        viewer: 'player',
      ));
    }

    return npcSprites;
  }

  List<PlayerSprite> createPlayerSprites(
      List<Player> players, Function() refresh) {
    List<PlayerSprite> playerSprites = [];

    for (Player player in players) {
      if (player.position != Position.empty()) {
        playerSprites.add(PlayerSprite(
          onTap: () {
            if (popUpMenuIsOpen) {
              closeMenu();
              refresh();
            } else {
              openMenu();
              refresh();
            }
          },
          player: player,
        ));
      }
    }

    return playerSprites;
  }

  bool popUpMenuIsOpen = false;

  Widget popUpMenu() {
    return PopUpMenu(popUpMenuIsOpen: popUpMenuIsOpen, closeMenu: closeMenu);
  }

  void openMenu() {
    popUpMenuIsOpen = true;
  }

  void closeMenu() {
    popUpMenuIsOpen = false;
  }
}
