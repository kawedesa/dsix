import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/chest/chest.dart';

class ChestList {
  static Chest normalChest = Chest(
      id: 0,
      name: 'normal chest',
      size: 10,
      position: Position.empty(),
      loot: [],
      locked: false);
  static Chest magicChest = Chest(
      id: 0,
      name: 'magic chest',
      size: 10,
      position: Position.empty(),
      loot: [],
      locked: true);

  List<Chest> getChestList() {
    return [
      normalChest,
      magicChest,
    ];
  }
}
