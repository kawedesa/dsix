import 'package:dsix/model/combat/ability.dart';
import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/attributes/attributes.dart';
import 'package:dsix/model/attributes/defense.dart';
import 'package:dsix/model/attributes/movement.dart';
import 'package:dsix/model/attributes/power.dart';
import 'package:dsix/model/attributes/vision.dart';
import 'package:dsix/model/combat/damage.dart';
import 'package:dsix/model/effect/effect_controller.dart';
import 'package:dsix/model/combat/life.dart';
import 'package:dsix/model/combat/range.dart';
import '../combat/armor.dart';
import '../combat/position.dart';
import 'npc.dart';

class NpcList {
  static Npc babyBear = Npc(
    id: 0,
    xp: 4,
    name: 'baby bear',
    size: 15,
    life: Life(current: 8, max: 8),
    armor: Armor(
      pArmor: 3,
      mArmor: 0,
    ),
    attributes: Attributes(
      availablePoints: 0,
      defense: Defense(attribute: 1, tempArmor: 0),
      power: Power(attribute: -1),
      movement: Movement(attribute: -1),
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
        effects: [''],
        isLoaded: false,
        needsReload: false,
      ),
    ],
    abilities: [],
    effects: EffectController(
      currentEffects: [],
      auras: [],
      onHit: [],
      onDamage: ['cry'],
      onDeath: ['baby death'],
      //TODO voltar aqui pra fazer o efeito de death of a baby
    ),
    loot: [],
  );

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
    attributes: Attributes(
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
          min: 5,
          max: 10,
          width: 18,
          shape: 'cone',
        ),
        effects: ['weaken'],
        isLoaded: false,
        needsReload: false,
      ),
    ],
    abilities: [],
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
    attributes: Attributes(
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
        effects: ['drain'],
        isLoaded: false,
        needsReload: false,
      ),
    ],
    abilities: [],
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
    attributes: Attributes(
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
    abilities: [],
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
    attributes: Attributes(
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
          shape: 'triangle',
        ),
        effects: ['weaken'],
        isLoaded: true,
        needsReload: true,
      ),
    ],
    abilities: [],
    effects: EffectController.empty(),
    loot: [],
  );

  static Npc skeletonWarrior = Npc(
    id: 0,
    xp: 10,
    name: 'skeleton warrior',
    size: 17,
    life: Life(current: 16, max: 16),
    armor: Armor(
      pArmor: 3,
      mArmor: 1,
    ),
    attributes: Attributes(
      availablePoints: 0,
      defense: Defense(attribute: 1, tempArmor: 0),
      power: Power(attribute: 1),
      movement: Movement(attribute: -1),
      vision: Vision(attribute: -1, tempVision: 0, canSeeInvisible: false),
    ),
    position: Position.empty(),
    attacks: [
      Attack(
        name: 'crush',
        type: 'melee',
        damage: Damage(pierce: 0, pDamage: 4, mDamage: 0, rawDamage: 0),
        range: Range(
          min: 7,
          max: 0,
          width: 3.5,
          shape: 'circle',
        ),
        effects: ['vulnerable', 'stun'],
        isLoaded: false,
        needsReload: false,
      ),
    ],
    abilities: [],
    effects: EffectController.empty(),
    loot: [],
  );

  static Npc demonHead = Npc(
    id: 0,
    xp: 10,
    name: 'demon head',
    size: 15,
    life: Life(current: 8, max: 8),
    armor: Armor(
      pArmor: 1,
      mArmor: 2,
    ),
    attributes: Attributes(
      availablePoints: 0,
      defense: Defense(attribute: 0, tempArmor: 0),
      power: Power(attribute: 0),
      movement: Movement(attribute: 1),
      vision: Vision(attribute: 2, tempVision: 0, canSeeInvisible: false),
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
        effects: [],
        isLoaded: false,
        needsReload: false,
      ),
      Attack(
        name: 'blast',
        type: 'melee',
        damage: Damage(pierce: 0, pDamage: 0, mDamage: 2, rawDamage: 0),
        range: Range(
          min: 0,
          max: 0,
          width: 12,
          shape: 'circle',
        ),
        effects: ['explode'],
        isLoaded: false,
        needsReload: false,
      ),
    ],
    abilities: [],
    effects: EffectController(
      currentEffects: [],
      auras: ['empower'],
      onHit: [],
      onDamage: [],
      onDeath: [],
    ),
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
    attributes: Attributes(
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
    abilities: [],
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
    attributes: Attributes(
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
        effects: ['knockback', 'kickback'],
        isLoaded: true,
        needsReload: true,
      ),
    ],
    abilities: [],
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
    attributes: Attributes(
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
          min: 10,
          max: 0,
          width: 3.5,
          shape: 'circle',
        ),
        effects: [],
        isLoaded: false,
        needsReload: false,
      ),
    ],
    abilities: [],
    effects: EffectController(
      currentEffects: [],
      auras: [],
      onHit: ['burn'],
      onDamage: [],
      onDeath: [],
    ),
    loot: [],
  );

  static Npc mamaBear = Npc(
    id: 0,
    xp: 14,
    name: 'mama bear',
    size: 25,
    life: Life(current: 24, max: 24),
    armor: Armor(
      pArmor: 5,
      mArmor: 0,
    ),
    attributes: Attributes(
      availablePoints: 0,
      defense: Defense(attribute: 2, tempArmor: 0),
      power: Power(attribute: 1),
      movement: Movement(attribute: 1),
      vision: Vision(attribute: 0, tempVision: 0, canSeeInvisible: false),
    ),
    position: Position.empty(),
    attacks: [
      Attack(
        name: 'bite',
        type: 'melee',
        damage: Damage(pierce: 1, pDamage: 3, mDamage: 0, rawDamage: 0),
        range: Range(
          min: 10,
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
        damage: Damage(pierce: 0, pDamage: 3, mDamage: 0, rawDamage: 0),
        range: Range(
          min: 7,
          max: 10,
          width: 30,
          shape: 'cone',
        ),
        effects: ['bleed', 'bleed'],
        isLoaded: false,
        needsReload: false,
      ),
    ],
    abilities: [],
    effects: EffectController.empty(),
    loot: [],
  );

  static Npc gnomeWizzard = Npc(
    id: 0,
    xp: 14,
    name: 'gnome wizzard',
    size: 15,
    life: Life(current: 16, max: 16),
    armor: Armor(
      pArmor: 0,
      mArmor: 0,
    ),
    attributes: Attributes(
      availablePoints: 0,
      defense: Defense(attribute: 0, tempArmor: 0),
      power: Power(attribute: 0),
      movement: Movement(attribute: 3),
      vision: Vision(attribute: 3, tempVision: 0, canSeeInvisible: false),
    ),
    position: Position.empty(),
    attacks: [],
    abilities: [
      Ability(name: 'mirror images', range: Range.empty(), effects: []),
      Ability(
          name: 'blind',
          range: Range(
            min: 5,
            max: 40,
            width: 10,
            shape: 'circle',
          ),
          effects: ['blind']),
      Ability(
          name: 'slow',
          range: Range(
            min: 5,
            max: 40,
            width: 10,
            shape: 'circle',
          ),
          effects: ['slow']),
    ],
    effects: EffectController.empty(),
    loot: [],
  );

  List<Npc> getNpcList() {
    return [
      babyBear,
      zombie,
      giantBat,
      skeleton,
      skeletonMage,
      skeletonWarrior,
      demonHead,
      giantFrog,
      goblin,
      basilisk,
      mamaBear,
      gnomeWizzard,
    ];
  }
}
