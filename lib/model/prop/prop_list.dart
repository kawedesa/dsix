import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/prop/prop.dart';

class PropList {
  static Prop chest = Prop(
      id: 0,
      name: 'chest',
      size: 15,
      type: 'normal',
      position: Position.empty(),
      loot: [],
      locked: true);

  static Prop vase = Prop(
      id: 0,
      name: 'vase',
      size: 15,
      type: 'blue',
      position: Position.empty(),
      loot: [],
      locked: false);

  List<Prop> getPropList() {
    return [
      chest,
      vase,
    ];
  }
}
