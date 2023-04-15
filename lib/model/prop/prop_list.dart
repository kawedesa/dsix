import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/prop/prop.dart';

class PropList {
  static Prop normalChest = Prop(
    id: 0,
    name: 'normal chest',
    size: 15,
    position: Position.empty(),
  );
  static Prop magicChest = Prop(
    id: 0,
    name: 'magic chest',
    size: 15,
    position: Position.empty(),
  );

  List<Prop> getPropList() {
    return [
      normalChest,
      magicChest,
    ];
  }
}
