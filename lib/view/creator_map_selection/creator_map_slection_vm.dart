import 'package:dsix/model/map/map_list.dart';

import '../../model/game/game.dart';

class CreatorMapSelectionVM {
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
