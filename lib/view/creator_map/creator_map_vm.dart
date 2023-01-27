import 'package:dsix/model/map/map_list.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:flutter/widgets.dart';
import '../../model/game/game.dart';

class CreatorMapVM {
  int mapSize = 320;
  double minZoom = 8;
  double maxZoom = 16;

  TransformationController createCanvasController(context) {
    updateMinZoom(context);
    TransformationController canvasController = TransformationController(
        Matrix4(
            minZoom, 0, 0, 0, 0, minZoom, 0, 0, 0, 0, minZoom, 0, 0, 0, 0, 1));
    return canvasController;
  }

  void updateMinZoom(context) {
    minZoom = 2 + AppLayout.longest(context) * 0.0025;
  }

  MapList mapList = MapList();

  void chooseMap(Game game) {
    game.map = mapList.mapList[0];
    game.update();
  }

  void chooseQuest(Game game) {
    game.quest = 'kill';
    game.update();
  }
}
