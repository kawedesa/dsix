import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/combat/attribute/attribute.dart';
import 'package:dsix/model/combat/attribute/defense.dart';
import 'package:dsix/model/combat/attribute/movement.dart';
import 'package:dsix/model/combat/attribute/power.dart';
import 'package:dsix/model/combat/attribute/vision.dart';
import 'package:dsix/model/combat/damage.dart';
import 'package:dsix/model/combat/effect/effect_controller.dart';
import 'package:dsix/model/combat/life.dart';
import 'package:dsix/model/combat/range.dart';
import '../combat/armor.dart';
import '../combat/position.dart';
import 'npc.dart';

class NpcList {
  static Npc zombie = Npc(
    id: 0,
    xp: 4,
    name: 'zombie',
    size: 20,
    life: Life(current: 16, max: 16),
    armor: Armor(
      pArmor: 0,
      mArmor: 0,
    ),
    attributes: Attribute(
      availablePoints: 0,
      defense: Defense(attribute: 0, tempArmor: 0),
      power: Power(attribute: 0),
      movement: Movement(attribute: -1),
      vision: Vision(attribute: -1, tempVision: 0, canSeeInvisible: false),
    ),
    position: Position.empty(),
    attacks: [
      Attack(
        name: 'bite',
        type: 'melee',
        damage: Damage(pierce: 1, pDamage: 3, mDamage: 0, rawDamage: 0),
        range: Range(
          min: 7,
          max: 0,
          width: 3.5,
          shape: 'circle',
        ),
        effects: [],
        isLoaded: false,
        needsReload: false,
      ),
      Attack(
        name: 'claw',
        type: 'melee',
        damage: Damage(pierce: 0, pDamage: 1, mDamage: 0, rawDamage: 0),
        range: Range(
          min: 3.5,
          max: 8,
          width: 16,
          shape: 'cone',
        ),
        effects: ['weaken'],
        isLoaded: false,
        needsReload: false,
      ),
    ],
    effects: EffectController.empty(),
    loot: [],
  );

  static Npc giantBat = Npc(
    id: 0,
    xp: 4,
    name: 'giant bat',
    size: 17,
    life: Life(current: 8, max: 8),
    armor: Armor(
      pArmor: 1,
      mArmor: 0,
    ),
    attributes: Attribute(
      availablePoints: 0,
      defense: Defense(attribute: 0, tempArmor: 0),
      power: Power(attribute: 0),
      movement: Movement(attribute: 0),
      vision: Vision(attribute: 0, tempVision: 0, canSeeInvisible: false),
    ),
    position: Position.empty(),
    attacks: [
      Attack(
        name: 'bite',
        type: 'melee',
        damage: Damage(pierce: 1, pDamage: 2, mDamage: 0, rawDamage: 0),
        range: Range(
          min: 7,
          max: 0,
          width: 3.5,
          shape: 'circle',
        ),
        //TODO ADD LEECH EFFECT
        effects: [],
        isLoaded: false,
        needsReload: false,
      ),
    ],
    effects: EffectController.empty(),
    loot: [],
  );

  static Npc skeleton = Npc(
    id: 0,
    xp: 4,
    name: 'skeleton',
    size: 17,
    life: Life(current: 8, max: 8),
    armor: Armor(
      pArmor: 2,
      mArmor: 0,
    ),
    attributes: Attribute(
      availablePoints: 0,
      defense: Defense(attribute: 0, tempArmor: 0),
      power: Power(attribute: 1),
      movement: Movement(attribute: -1),
      vision: Vision(attribute: -1, tempVision: 0, canSeeInvisible: false),
    ),
    position: Position.empty(),
    attacks: [
      Attack(
        name: 'slash',
        type: 'melee',
        damage: Damage(pierce: 0, pDamage: 2, mDamage: 0, rawDamage: 0),
        range: Range(
          min: 5,
          max: 10,
          width: 20,
          shape: 'cone',
        ),
        effects: [],
        isLoaded: false,
        needsReload: false,
      ),
    ],
    effects: EffectController.empty(),
    loot: [],
  );

  static Npc skeletonMage = Npc(
    id: 0,
    xp: 10,
    name: 'skeleton mage',
    size: 17,
    life: Life(current: 8, max: 8),
    armor: Armor(
      pArmor: 1,
      mArmor: 2,
    ),
    attributes: Attribute(
      availablePoints: 0,
      defense: Defense(attribute: 0, tempArmor: 0),
      power: Power(attribute: 1),
      movement: Movement(attribute: 0),
      vision: Vision(attribute: 2, tempVision: 0, canSeeInvisible: false),
    ),
    position: Position.empty(),
    attacks: [
      Attack(
        name: 'blast',
        type: 'ranged',
        damage: Damage(pierce: 0, pDamage: 0, mDamage: 1, rawDamage: 0),
        range: Range(
          min: 40,
          max: 0,
          width: 10,
          shape: 'circle',
        ),
        effects: [],
        isLoaded: false,
        needsReload: false,
      ),
      Attack(
        name: 'shot',
        type: 'ranged',
        damage: Damage(pierce: 0, pDamage: 0, mDamage: 2, rawDamage: 0),
        range: Range(
          min: 6,
          max: 28,
          width: 8,
          shape: 'cone',
        ),
        effects: ['weaken'],
        isLoaded: true,
        needsReload: true,
      ),
    ],
    effects: EffectController.empty(),
    loot: [],
  );

  static Npc giantFrog = Npc(
    id: 0,
    xp: 10,
    name: 'giant frog',
    size: 17,
    life: Life(current: 16, max: 16),
    armor: Armor(
      pArmor: 2,
      mArmor: 0,
    ),
    attributes: Attribute(
      availablePoints: 0,
      defense: Defense(attribute: 0, tempArmor: 0),
      power: Power(attribute: 1),
      movement: Movement(attribute: 2),
      vision: Vision(attribute: 1, tempVision: 0, canSeeInvisible: false),
    ),
    position: Position.empty(),
    attacks: [
      Attack(
        name: 'tongue',
        type: 'melee',
        damage: Damage(pierce: 0, pDamage: 2, mDamage: 0, rawDamage: 0),
        range: Range(
          min: 7,
          max: 25,
          width: 7,
          shape: 'triangle',
        ),
        effects: ['poison', 'poison'],
        isLoaded: false,
        needsReload: false,
      ),
    ],
    effects: EffectController.empty(),
    loot: [],
  );

  static Npc goblin = Npc(
    id: 0,
    xp: 10,
    name: 'goblin',
    size: 15,
    life: Life(current: 8, max: 8),
    armor: Armor(
      pArmor: 1,
      mArmor: 0,
    ),
    attributes: Attribute(
      availablePoints: 0,
      defense: Defense(attribute: 0, tempArmor: 0),
      power: Power(attribute: 2),
      movement: Movement(attribute: 0),
      vision: Vision(attribute: 2, tempVision: 0, canSeeInvisible: false),
    ),
    position: Position.empty(),
    attacks: [
      Attack(
        name: 'slash',
        type: 'melee',
        damage: Damage(pierce: 0, pDamage: 1, mDamage: 0, rawDamage: 0),
        range: Range(
          min: 3.5,
          max: 8,
          width: 16,
          shape: 'cone',
        ),
        effects: ['bleed'],
        isLoaded: false,
        needsReload: false,
      ),
      Attack(
        name: 'shot',
        type: 'ranged',
        damage: Damage(pierce: 0, pDamage: 4, mDamage: 0, rawDamage: 0),
        range: Range(
          min: 7,
          max: 80,
          width: 7,
          shape: 'triangle',
        ),
        effects: [],
        isLoaded: true,
        needsReload: true,
      ),
    ],
    effects: EffectController.empty(),
    loot: [],
  );

  static Npc basilisk = Npc(
    id: 0,
    xp: 10,
    name: 'basilisk',
    size: 25,
    life: Life(current: 16, max: 16),
    armor: Armor(
      pArmor: 2,
      mArmor: 0,
    ),
    attributes: Attribute(
      availablePoints: 0,
      defense: Defense(attribute: 0, tempArmor: 0),
      power: Power(attribute: 2),
      movement: Movement(attribute: 1),
      vision: Vision(attribute: 1, tempVision: 0, canSeeInvisible: false),
    ),
    position: Position.empty(),
    attacks: [
      Attack(
        name: 'shot',
        type: 'ranged',
        damage: Damage(pierce: 0, pDamage: 0, mDamage: 2, rawDamage: 0),
        range: Range(
          min: 6,
          max: 28,
          width: 8,
          shape: 'cone',
        ),
        effects: ['burn', 'burn'],
        isLoaded: true,
        needsReload: true,
      ),
      Attack(
        name: 'bite',
        type: 'melee',
        damage: Damage(pierce: 1, pDamage: 3, mDamage: 0, rawDamage: 0),
        range: Range(
          min: 7,
          max: 0,
          width: 3.5,
          shape: 'circle',
        ),
        effects: [],
        isLoaded: false,
        needsReload: false,
      ),
    ],
    effects: EffectController(
      currentEffects: [],
      onBeignHitEffects: ['burn'],
      onDeathEffects: [],
    ),
    loot: [],
  );

  // static Npc explosiveLizzard = Npc(
  //   id: 0,
  //   xp: 10,
  //   name: 'explosive lizzard',
  //   size:15,
  //   life: Life(current: 8, max: 8),
  //   armor: Armor(
  //     pArmor: 0,
  //     mArmor: 0,
  //   ),
  //   attributes: Attribute(
  //     availablePoints: 0,
  //     defense: Defense(attribute: 0, tempArmor: 0),
  //     power: Power(attribute: 3),
  //     movement: Movement(attribute: 2),
  //     vision: Vision(attribute: 1, tempVision: 0, canSeeInvisible: false),
  //   ),
  //   position: Position.empty(),
  //   attacks: [
  //     Attack(
  //       name: 'explode',
  //       type: 'ranged',
  //       damage: Damage(pierce: 0, pDamage: 4, mDamage: 0, rawDamage: 0),
  //       range: Range(
  //         min: 0,
  //         max: 0,
  //         width: 10,
  //         shape: 'circle',
  //       ),
  //       effects: [],
  //       isLoaded: false,
  //       needsReload: false,
  //     ),
  //   ],
  //   effects: EffectController.empty(),
  //   loot: [],
  // );

  // static Npc wraith = Npc(
  //   id: 0,
  //   xp: 14,
  //   name: 'wraith',
  //   size:15,
  //   life: Life(current: 16, max: 16),
  //   armor: Armor(
  //     pArmor: 3,
  //     mArmor: 0,
  //   ),
  //   attributes: Attribute(
  //     availablePoints: 0,
  //     defense: Defense(attribute: 0, tempArmor: 0),
  //     power: Power(attribute: 2),
  //     movement: Movement(attribute: 1),
  //     vision: Vision(attribute: 1, tempVision: 0, canSeeInvisible: false),
  //   ),
  //   position: Position.empty(),
  //   attacks: [
  //     Attack(
  //       name: 'drain',
  //       type: 'melee',
  //       damage: Damage(pierce: 0, pDamage: 0, mDamage: 2, rawDamage: 0),
  //       range: Range(min: 0.05, max: 5, width: 0, shape: 'ring'),
  //       effects: ['drain'],
  //       isLoaded: false,
  //       needsReload: false,
  //     ),
  //     Attack(
  //       name: 'dark bolt',
  //       type: 'ranged',
  //       damage: Damage(pierce: 0, pDamage: 0, mDamage: 3, rawDamage: 0),
  //       range: Range(min: 5, max: 30, width: 5, shape: 'rectangle'),
  //       effects: [],
  //       isLoaded: false,
  //       needsReload: false,
  //     ),
  //   ],
  //   effects: EffectController(
  //     currentEffects: [],
  //     onBeignHitEffects: [],
  //     onDeathEffects: [],
  //   ),
  //   loot: [],
  // );

  // static Npc golen = Npc(
  //   id: 0,
  //   xp: 14,
  //   name: 'golen',
  //   size:15,
  //   life: Life(current: 24, max: 24),
  //   armor: Armor(
  //     pArmor: 2,
  //     mArmor: 2,
  //   ),
  //   attributes: Attribute(
  //     availablePoints: 0,
  //     defense: Defense(attribute: 0, tempArmor: 0),
  //     power: Power(attribute: 1),
  //     movement: Movement(attribute: 3),
  //     vision: Vision(attribute: 0, tempVision: 0, canSeeInvisible: false),
  //   ),
  //   position: Position.empty(),
  //   attacks: [
  //     Attack(
  //       name: 'roll',
  //       type: 'melee',
  //       damage: Damage(pierce: 0, pDamage: 3, mDamage: 0, rawDamage: 0),
  //       range: Range(min: 5, max: 50, width: 20, shape: 'rectangle'),
  //       effects: [],
  //       isLoaded: true,
  //       needsReload: true,
  //     ),
  //   ],
  //   effects: EffectController.empty(),
  //   loot: [],
  // );

  List<Npc> getNpcList() {
    return [
      zombie,
      giantBat,
      skeleton,
      skeletonMage,
      giantFrog,
      goblin,
      basilisk,
      // explosiveLizzard,
      // wraith,
      // golen,
    ];
  }
}
