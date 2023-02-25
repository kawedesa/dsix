import 'package:dsix/model/combat/ability/ability_list.dart';
import 'package:dsix/model/combat/attribute/movement.dart';
import 'package:dsix/model/combat/attribute/vision.dart';
import 'package:dsix/model/combat/damage.dart';
import 'package:dsix/model/combat/life.dart';
import '../combat/armor.dart';
import '../combat/position.dart';
import 'npc.dart';

class NpcList {
  static Npc zombie = Npc(
    id: 0,
    race: 'zombie',
    size: 10,
    life: Life(current: 10, max: 10),
    damage: Damage(
      pDamage: 0,
      mDamage: 0,
    ),
    armor: Armor(
      pArmor: 0,
      mArmor: 0,
    ),
    movement: Movement(attribute: -1),
    vision: Vision(attribute: -1),
    position: Position.empty(),
    abilities: [
      AbilityList.bite,
      AbilityList.slash,
      AbilityList.shot,
    ],
  );

  static Npc skeletonMage = Npc(
    id: 0,
    race: 'skeleton mage',
    size: 10,
    life: Life(current: 8, max: 8),
    damage: Damage(
      pDamage: 0,
      mDamage: 0,
    ),
    armor: Armor(
      pArmor: 0,
      mArmor: 0,
    ),
    movement: Movement(attribute: 0),
    vision: Vision(attribute: 1),
    position: Position.empty(),
    abilities: [],
  );
  // static Npc skeleton = Npc(
  //   id: 0,
  //   race: 'skeleton',
  //   size: 10,
  //   life: Life(current: 8, max: 8),
  //   damage: Damage(
  //     pDamage: 0,
  //     mDamage: 0,
  //   ),
  //   armor: Armor(
  //     pArmor: 0,
  //     mArmor: 0,
  //   ),
  //   position: Position.empty(),
  //   abilities: [
  //     AbilityList.bite,
  //     AbilityList.slash,
  //   ],
  // );

  // static Npc goblin = Npc(
  //   id: 0,
  //   race: 'goblin',
  //   size: 10,
  //   life: Life(current: 8, max: 8),
  //   damage: Damage(
  //     pDamage: 0,
  //     mDamage: 0,
  //   ),
  //   armor: Armor(
  //     pArmor: 0,
  //     mArmor: 0,
  //   ),
  //   position: Position.empty(),
  //   abilities: [],
  // );
  // static Npc golen = Npc(
  //   id: 0,
  //   race: 'golen',
  //   size: 10,
  //   life: Life(current: 8, max: 8),
  //   damage: Damage(
  //     pDamage: 0,
  //     mDamage: 0,
  //   ),
  //   armor: Armor(
  //     pArmor: 0,
  //     mArmor: 0,
  //   ),
  //   position: Position.empty(),
  //   abilities: [],
  // );
  // static Npc vampire = Npc(
  //   id: 0,
  //   race: 'vampire',
  //   size: 10,
  //   life: Life(current: 8, max: 8),
  //   damage: Damage(
  //     pDamage: 0,
  //     mDamage: 0,
  //   ),
  //   armor: Armor(
  //     pArmor: 0,
  //     mArmor: 0,
  //   ),
  //   position: Position.empty(),
  //   abilities: [],
  // );

  List<Npc> getNpcList() {
    return [
      zombie,

      skeletonMage,
      //    skeleton,
      // vampire,
      // goblin,
      // golen,
    ];
  }
}
