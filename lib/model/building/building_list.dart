import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/combat/armor.dart';
import 'package:dsix/model/combat/life.dart';
import 'package:dsix/model/combat/position.dart';

class BuildingList {
  static Building blackTablet = Building(
      id: 0,
      name: 'black tablet',
      size: 32,
      life: Life(current: 16, max: 16),
      position: Position.empty(),
      armor: Armor.empty());
  static Building divineAltar = Building(
      id: 0,
      name: 'divine altar',
      size: 32,
      life: Life(current: 16, max: 16),
      position: Position.empty(),
      armor: Armor.empty());
  static Building earthAltar = Building(
      id: 0,
      name: 'earth altar',
      size: 32,
      life: Life(current: 16, max: 16),
      position: Position.empty(),
      armor: Armor.empty());
  static Building sacrificeAltar = Building(
      id: 0,
      name: 'sacrifice altar',
      size: 32,
      life: Life(current: 16, max: 16),
      position: Position.empty(),
      armor: Armor.empty());

  static Building tower = Building(
      id: 0,
      name: 'tower',
      size: 32,
      life: Life(current: 16, max: 16),
      position: Position.empty(),
      armor: Armor.empty());

  static Building barricade = Building(
      id: 0,
      name: 'barricade',
      size: 32,
      life: Life(current: 16, max: 16),
      position: Position.empty(),
      armor: Armor.empty());

  List<Building> getBuildingList() {
    return [
      blackTablet,
      divineAltar,
      earthAltar,
      sacrificeAltar,
      tower,
      barricade,
    ];
  }
}
