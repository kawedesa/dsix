import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/shared/app_widgets/map/map_info.dart';

class CreatorMapVM {
  final MapInfo mapInfo = MapInfo.empty();

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

  void deselectNpc() {
    if (selectedNpc == null) {
      return;
    } else {
      selectedNpc = null;
    }
  }

  void createNpc(Position position) {
    selectedNpc!.changePosition(position);
    selectedNpc!.set();
  }
}
