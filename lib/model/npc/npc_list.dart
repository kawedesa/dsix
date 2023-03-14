import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/combat/attribute/movement.dart';
import 'package:dsix/model/combat/attribute/power.dart';
import 'package:dsix/model/combat/attribute/vision.dart';
import 'package:dsix/model/combat/damage.dart';
import 'package:dsix/model/combat/effect/effect.dart';
import 'package:dsix/model/combat/effect/effect_controller.dart';
import 'package:dsix/model/combat/effect/passive_effects.dart';
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
    size: 10,
    life: Life(current: 16, max: 16),
    armor: Armor(
      pArmor: 0,
      mArmor: 0,
    ),
    power: Power(attribute: 0),
    movement: Movement(attribute: -1),
    vision: Vision(attribute: -1, tempVision: 0, canSeeInvisible: false),
    position: Position.empty(),
    attacks: [
      Attack(
        name: 'bite',
        damage: Damage(pDamage: 3, mDamage: 0, rawDamage: 0),
        range: Range(min: 6, max: 0, width: 4, shape: 'circle'),
        onHitEffect: Effect.empty(),
      ),
      Attack(
        name: 'slash',
        damage: Damage(pDamage: 1, mDamage: 0, rawDamage: 0),
        range: Range(
          min: 5,
          max: 8,
          width: 16,
          shape: 'cone',
        ),
        onHitEffect: Effect.empty(),
      ),
    ],
    effects: EffectController.empty(),
    loot: [],
  );

  static Npc giantBat = Npc(
    id: 0,
    xp: 4,
    name: 'giant bat',
    size: 10,
    life: Life(current: 8, max: 8),
    armor: Armor(
      pArmor: 1,
      mArmor: 0,
    ),
    power: Power(attribute: 0),
    movement: Movement(attribute: 0),
    vision: Vision(attribute: 0, tempVision: 0, canSeeInvisible: false),
    position: Position.empty(),
    attacks: [
      Attack(
        name: 'bite',
        damage: Damage(pDamage: 2, mDamage: 0, rawDamage: 0),
        range: Range(min: 6, max: 0, width: 4, shape: 'circle'),
        onHitEffect: Effect.empty(),
      ),
    ],
    effects: EffectController.empty(),
    loot: [],
  );

  static Npc skeleton = Npc(
    id: 0,
    xp: 4,
    name: 'skeleton',
    size: 10,
    life: Life(current: 8, max: 8),
    armor: Armor(
      pArmor: 2,
      mArmor: 0,
    ),
    power: Power(attribute: 1),
    movement: Movement(attribute: -1),
    vision: Vision(attribute: -1, tempVision: 0, canSeeInvisible: false),
    position: Position.empty(),
    attacks: [
      Attack(
        name: 'slash',
        damage: Damage(pDamage: 2, mDamage: 0, rawDamage: 0),
        range: Range(
          min: 5,
          max: 10,
          width: 18,
          shape: 'cone',
        ),
        onHitEffect: Effect.empty(),
      ),
    ],
    effects: EffectController.empty(),
    loot: [],
  );

  static Npc skeletonMage = Npc(
    id: 0,
    xp: 10,
    name: 'skeleton mage',
    size: 10,
    life: Life(current: 8, max: 8),
    armor: Armor(
      pArmor: 1,
      mArmor: 2,
    ),
    power: Power(attribute: 1),
    movement: Movement(attribute: 0),
    vision: Vision(attribute: 2, tempVision: 0, canSeeInvisible: false),
    position: Position.empty(),
    attacks: [
      Attack(
        name: 'blast',
        damage: Damage(pDamage: 0, mDamage: 1, rawDamage: 0),
        range: Range(
          min: 40,
          max: 0,
          width: 10,
          shape: 'circle',
        ),
        onHitEffect: Effect.empty(),
      ),
      Attack(
        name: 'shot',
        damage: Damage(pDamage: 0, mDamage: 2, rawDamage: 0),
        range: Range(
          min: 5,
          max: 20,
          width: 5,
          shape: 'rectangle',
        ),
        onHitEffect: Effect.empty(),
      ),
    ],
    effects: EffectController.empty(),
    loot: [],
  );

  static Npc giantFrog = Npc(
    id: 0,
    xp: 10,
    name: 'giant frog',
    size: 10,
    life: Life(current: 16, max: 16),
    armor: Armor(
      pArmor: 2,
      mArmor: 0,
    ),
    power: Power(attribute: 1),
    movement: Movement(attribute: 2),
    vision: Vision(attribute: 1, tempVision: 0, canSeeInvisible: false),
    position: Position.empty(),
    attacks: [
      Attack(
        name: 'tongue',
        damage: Damage(pDamage: 2, mDamage: 0, rawDamage: 0),
        range: Range(
          min: 5,
          max: 17.5,
          width: 5,
          shape: 'rectangle',
        ),
        onHitEffect: Effect(
          name: 'poison',
          description: 'it burns',
          value: 1,
          countdown: 1,
        ),
      ),
    ],
    effects: EffectController.empty(),
    loot: [],
  );

  static Npc goblin = Npc(
    id: 0,
    xp: 10,
    name: 'goblin',
    size: 10,
    life: Life(current: 8, max: 8),
    armor: Armor(
      pArmor: 1,
      mArmor: 0,
    ),
    power: Power(attribute: 2),
    movement: Movement(attribute: 0),
    vision: Vision(attribute: 2, tempVision: 0, canSeeInvisible: false),
    position: Position.empty(),
    attacks: [
      Attack(
        name: 'slash',
        damage: Damage(pDamage: 1, mDamage: 0, rawDamage: 0),
        range: Range(
          min: 5,
          max: 5,
          width: 7.5,
          shape: 'cone',
        ),
        onHitEffect:
            Effect(name: 'bleed', description: '', value: 1, countdown: 1),
      ),
      Attack(
        name: 'shot',
        damage: Damage(pDamage: 3, mDamage: 0, rawDamage: 0),
        range: Range(min: 20, max: 50, width: 5, shape: 'rectangle'),
        onHitEffect: Effect.empty(),
      ),
    ],
    effects: EffectController.empty(),
    loot: [],
  );
  static Npc beast = Npc(
    id: 0,
    xp: 10,
    name: 'beast',
    size: 10,
    life: Life(current: 16, max: 16),
    armor: Armor(
      pArmor: 2,
      mArmor: 0,
    ),
    power: Power(attribute: 2),
    movement: Movement(attribute: 1),
    vision: Vision(attribute: 1, tempVision: 0, canSeeInvisible: false),
    position: Position.empty(),
    attacks: [
      Attack(
        name: 'slash',
        damage: Damage(pDamage: 2, mDamage: 0, rawDamage: 0),
        range: Range(
          min: 5,
          max: 15,
          width: 20,
          shape: 'cone',
        ),
        onHitEffect: Effect.empty(),
      ),
    ],
    effects: EffectController(
      currentEffects: [],
      passiveEffects: PassiveEffects(
          onBeingHitEffect: Effect(
            name: 'thorn',
            description: 'spiky',
            value: 1,
            countdown: 0,
          ),
          afterAttackEffect: Effect.empty()),
    ),
    loot: [],
  );

  static Npc explosiveLizzard = Npc(
    id: 0,
    xp: 10,
    name: 'explosive lizzard',
    size: 10,
    life: Life(current: 8, max: 8),
    armor: Armor(
      pArmor: 0,
      mArmor: 0,
    ),
    power: Power(attribute: 3),
    movement: Movement(attribute: 2),
    vision: Vision(attribute: 1, tempVision: 0, canSeeInvisible: false),
    position: Position.empty(),
    attacks: [
      Attack(
        name: 'explode',
        damage: Damage(pDamage: 4, mDamage: 0, rawDamage: 0),
        range: Range(
          min: 0,
          max: 0,
          width: 10,
          shape: 'circle',
        ),
        onHitEffect: Effect.empty(),
      ),
    ],
    effects: EffectController.empty(),
    loot: [],
  );

  static Npc wraith = Npc(
    id: 0,
    xp: 14,
    name: 'wraith',
    size: 10,
    life: Life(current: 16, max: 16),
    armor: Armor(
      pArmor: 3,
      mArmor: 0,
    ),
    power: Power(attribute: 2),
    movement: Movement(attribute: 1),
    vision: Vision(attribute: 1, tempVision: 0, canSeeInvisible: false),
    position: Position.empty(),
    attacks: [
      Attack(
        name: 'drain',
        damage: Damage(pDamage: 0, mDamage: 2, rawDamage: 0),
        range: Range(min: 0.05, max: 5, width: 0, shape: 'torus'),
        onHitEffect: Effect(
          name: 'drain',
          description: 'steals the soul',
          value: 1,
          countdown: 0,
        ),
      ),
      Attack(
        name: 'dark bolt',
        damage: Damage(pDamage: 0, mDamage: 3, rawDamage: 0),
        range: Range(min: 5, max: 30, width: 5, shape: 'rectangle'),
        onHitEffect: Effect.empty(),
      ),
    ],
    effects: EffectController(
      currentEffects: [],
      passiveEffects: PassiveEffects(
        onBeingHitEffect: Effect.empty(),
        afterAttackEffect: Effect(
          name: 'heal',
          description: '',
          value: 1,
          countdown: 0,
        ),
      ),
    ),
    loot: [],
  );

  static Npc golen = Npc(
    id: 0,
    xp: 14,
    name: 'golen',
    size: 10,
    life: Life(current: 24, max: 24),
    armor: Armor(
      pArmor: 2,
      mArmor: 2,
    ),
    power: Power(attribute: 1),
    movement: Movement(attribute: 3),
    vision: Vision(attribute: 0, tempVision: 0, canSeeInvisible: false),
    position: Position.empty(),
    attacks: [
      Attack(
        name: 'roll',
        damage: Damage(
          pDamage: 3,
          mDamage: 0,
          rawDamage: 0,
        ),
        range: Range(min: 5, max: 50, width: 20, shape: 'rectangle'),
        onHitEffect: Effect.empty(),
      ),
    ],
    effects: EffectController.empty(),
    loot: [],
  );

  List<Npc> getNpcList() {
    return [
      zombie,
      giantBat,
      skeleton,
      skeletonMage,
      giantFrog,
      goblin,
      beast,
      explosiveLizzard,
      wraith,
      golen,
    ];
  }
}
