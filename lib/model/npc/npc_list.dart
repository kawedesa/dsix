import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/combat/attribute/movement.dart';
import 'package:dsix/model/combat/attribute/power.dart';
import 'package:dsix/model/combat/attribute/vision.dart';
import 'package:dsix/model/combat/damage.dart';
import 'package:dsix/model/combat/life.dart';
import 'package:dsix/model/combat/range.dart';
import '../combat/armor.dart';
import '../combat/position.dart';
import 'npc.dart';

class NpcList {
  static Npc zombie = Npc(
    id: 0,
    race: 'zombie',
    size: 10,
    life: Life(current: 15, max: 15),
    armor: Armor(
      pArmor: 0,
      mArmor: 0,
    ),
    power: Power(attribute: 0),
    movement: Movement(attribute: -1),
    vision: Vision(attribute: -1),
    position: Position.empty(),
    attacks: [
      Attack(
        name: 'bite',
        damage: Damage(pDamage: 3, mDamage: 0),
        range: Range(min: 10, max: 0, width: 5, shape: 'circle'),
      ),
      Attack(
          name: 'slash',
          damage: Damage(pDamage: 1, mDamage: 0),
          range: Range(
            min: 5,
            max: 12.5,
            width: 12.5,
            shape: 'cone',
          )),
    ],
  );

  static Npc skeletonMage = Npc(
    id: 0,
    race: 'skeleton mage',
    size: 10,
    life: Life(current: 8, max: 8),
    armor: Armor(
      pArmor: 1,
      mArmor: 1,
    ),
    power: Power(attribute: 1),
    movement: Movement(attribute: 0),
    vision: Vision(attribute: 1),
    position: Position.empty(),
    attacks: [
      Attack(
          name: 'blast',
          damage: Damage(pDamage: 0, mDamage: 1),
          range: Range(
            min: 30,
            max: 20,
            width: 15,
            shape: 'circle',
          )),
      Attack(
          name: 'shot',
          damage: Damage(pDamage: 0, mDamage: 2),
          range: Range(
            min: 10,
            max: 70,
            width: 7.5,
            shape: 'rectangle',
          )),
    ],
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
