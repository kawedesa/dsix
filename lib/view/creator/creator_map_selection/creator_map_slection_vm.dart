import 'package:dsix/model/map/map_list.dart';
import '../../../model/game/game.dart';

class CreatorMapSelectionVM {
  MapList mapList = MapList();
  String mapName = 'old ruins';
  int mapIndex = 1;

  void changeMap(int value) {
    mapIndex += value;
    if (mapIndex > mapList.availableMaps.length - 1) {
      mapIndex = 0;
    }
    if (mapIndex < 0) {
      mapIndex = mapList.availableMaps.length - 1;
    }

    mapName = mapList.availableMaps[mapIndex].name;
  }

  void chooseMap(Game game) {
    game.map = mapList.availableMaps[mapIndex].name;
    game.update();
  }

  void chooseQuest(Game game) {
    game.quest = 'kill';
    game.update();
  }
}
