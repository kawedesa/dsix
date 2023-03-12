import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/shared/app_widgets/map/map_info.dart';

class CreatorMapVM {
  final MapInfo mapInfo = MapInfo.empty();

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

  void deselectBuilding() {
    if (selectedBuilding == null) {
      return;
    } else {
      selectedBuilding = null;
    }
  }

  void duplicateBuilding() {
    Building newBuilding = selectedBuilding!;
    newBuilding.id = DateTime.now().millisecondsSinceEpoch;
    newBuilding.position.dx += 5;
    newBuilding.set();
    selectedBuilding = newBuilding;
  }

  void createBuilding(Position position) {
    selectedBuilding!.changePosition(position);
    selectedBuilding!.set();
  }

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

  void duplicateNpc() {
    Npc newNpc = selectedNpc!;
    newNpc.id = DateTime.now().millisecondsSinceEpoch;
    newNpc.position.dx += 5;
    newNpc.set();
    selectedNpc = newNpc;
  }

  void createNpc(Position position) {
    selectedNpc!.changePosition(position);
    selectedNpc!.set();
  }
}
