import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/spawner/spawner_sprite.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../model/npc/npc.dart';
import '../../model/npc/npc_sprite.dart';

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

  void createSpawner(int id) {
    Spawner newSpawner = Spawner.newSpawner(id, 50.0);
    newSpawner.set();
  }

  List<SpawnerSprite> createSpawnerSprites(context, List<Spawner> spawners) {
    List<SpawnerSprite> spawnerSprites = [];

    for (Spawner spawner in spawners) {
      spawnerSprites.add(SpawnerSprite(
        spawner: spawner,
      ));
    }

    return spawnerSprites;
  }

  void createNpc(int id, Npc selectedNpc) {
    Npc newNpc = selectedNpc;
    newNpc.id = id;
    newNpc.set();
  }

  List<NpcSprite> createNpcSprites(context, List<Npc> npcs) {
    List<NpcSprite> npcSprites = [];

    for (Npc npc in npcs) {
      npcSprites.add(NpcSprite(
        npc: npc,
      ));
    }

    return npcSprites;
  }
}
