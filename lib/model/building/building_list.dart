import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/combat/position.dart';

class BuildingList {
  static Building blackTablet = Building(
    id: 0,
    name: 'black tablet',
    size: 32,
    position: Position.empty(),
    alwaysVisible: true,
  );
  static Building divineAltar = Building(
    id: 0,
    name: 'divine altar',
    size: 32,
    position: Position.empty(),
    alwaysVisible: true,
  );
  static Building earthAltar = Building(
    id: 0,
    name: 'earth altar',
    size: 32,
    position: Position.empty(),
    alwaysVisible: true,
  );
  static Building sacrificeAltar = Building(
    id: 0,
    name: 'sacrifice altar',
    size: 32,
    position: Position.empty(),
    alwaysVisible: true,
  );

  static Building tower = Building(
    id: 0,
    name: 'tower',
    size: 32,
    position: Position.empty(),
    alwaysVisible: true,
  );

  static Building barricade = Building(
    id: 0,
    name: 'barricade',
    size: 32,
    position: Position.empty(),
    alwaysVisible: true,
  );

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
