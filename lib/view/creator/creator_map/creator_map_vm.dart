import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/shared/app_widgets/sprite/spawner_sprite.dart';
import 'package:dsix/shared/app_layout.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../model/combat/position.dart';
import '../../../model/npc/npc.dart';
import '../../../shared/app_widgets/sprite/npc_sprite.dart';
import '../../../shared/app_widgets/sprite/player_sprite.dart';

class CreatorMapVM {
  int mapSize = 320;
  double minZoom = 8;
  double maxZoom = 16;
  TransformationController? canvasController;

  TransformationController createCanvasController(context) {
    updateMinZoom(context);

    canvasController ??= TransformationController(Matrix4(
        minZoom, 0, 0, 0, 0, minZoom, 0, 0, 0, 0, minZoom, 0, 0, 0, 0, 1));

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
        viewer: 'creator',
      ));
    }

    return npcSprites;
  }

  List<PlayerSprite> createPlayerSprites(List<Player> players) {
    List<PlayerSprite> playerSprites = [];

    for (Player player in players) {
      if (player.position != Position.empty()) {
        playerSprites.add(PlayerSprite(
          player: player,
        ));
      }
    }

    return playerSprites;
  }
}
