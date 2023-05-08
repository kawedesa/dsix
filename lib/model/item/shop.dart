import 'package:dsix/model/combat/armor.dart';
import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/combat/damage.dart';
import 'package:dsix/model/combat/range.dart';
import 'dart:math';
import 'item.dart';

class Shop {
  List<Item> createChestLoot(int value, String type) {
    List<Item> loot = [];
    int lootValue = value;
    int currentValue = 0;

    while (currentValue < lootValue) {
      int leftOverAmount = lootValue - currentValue;

      if (leftOverAmount < 100) {
        loot.add(createGold(leftOverAmount));
        currentValue += leftOverAmount;
        continue;
      }

      String category = lootCategory(type);
      Item newItem = randomItem(category);

      if (currentValue + newItem.value <= lootValue) {
        loot.add(newItem);
        currentValue += newItem.value;
      }
    }

    switch (type) {
      case 'magic':
        for (int i = 0; i < 3; i++) {
          int randomItem = Random().nextInt(loot.length);
          loot[randomItem] = randomItemEnchant(loot[randomItem]);
        }

        break;
    }

    return loot;
  }

  List<Item> createNpcLoot(int value) {
    List<Item> loot = [];
    int lootValue = value;
    int currentValue = 0;

    while (currentValue < lootValue) {
      int leftOverAmount = lootValue - currentValue;

      if (leftOverAmount < 100) {
        loot.add(createGold(leftOverAmount));
        currentValue += leftOverAmount;
        continue;
      }

      String category = lootCategory('npc');
      Item newItem = randomItem(category);

      if (currentValue + newItem.value <= lootValue) {
        loot.add(newItem);
        currentValue += newItem.value;
      }
    }
    return loot;
  }

  String lootCategory(String lootType) {
    List<String> category = [];

    switch (lootType) {
      case 'npc':
        category = [
          'light weapons',
          'heavy weapons',
          'ranged weapons',
          // 'magic weapons',
          'armor',
          'consumables',
        ];
        break;
      case 'normal':
        category = [
          'light weapons',
          'heavy weapons',
          'ranged weapons',
          // 'magic weapons',
          'armor',
          'consumables',
        ];
        break;
      case 'magic':
        category = [
          'light weapons',
          'heavy weapons',
          'ranged weapons',
          // 'magic weapons',
          'armor',
        ];
        break;
    }

    int randomCategory = Random().nextInt(category.length);
    return category[randomCategory];
  }

  Item createGold(int value) {
    Item gold = Item(
        name: 'gold',
        description: 'shiny',
        itemSlot: 'gold',
        effects: [],
        attacks: [],
        armor: Armor.empty(),
        enchanted: false,
        weight: 0,
        value: value);

    return gold;
  }

  Item randomItem(String category) {
    Item newItem = Item.empty();
    int randomItem = 0;
    switch (category) {
      case 'light weapons':
        randomItem = Random().nextInt(lightWeapons.length - 1);
        newItem = lightWeapons[randomItem];
        break;

      case 'heavy weapons':
        randomItem = Random().nextInt(heavyWeapons.length - 1);
        newItem = heavyWeapons[randomItem];
        break;

      case 'ranged weapons':
        randomItem = Random().nextInt(rangedWeapons.length - 1);
        newItem = rangedWeapons[randomItem];
        break;

      // case 'magic weapons':
      //   randomItem = Random().nextInt(magicWeapons.length - 1);
      //   newItem = rangedWeapons[randomItem];
      //   break;

      case 'armor':
        randomItem = Random().nextInt(armor.length - 1);
        newItem = armor[randomItem];
        break;

      case 'consumables':
        randomItem = Random().nextInt(consumables.length - 1);
        newItem = consumables[randomItem];
        break;
    }
    return newItem;
  }

  Item randomItemEnchant(Item item) {
    Item enchantedItem = item;
    bool hasAttacks = false;

    if (enchantedItem.attacks.isNotEmpty) {
      hasAttacks = true;
    }

    List<String> possibleWeaponEnchants = [
      'pDamage',
      'mDamage',
      'pArmor',
      'mArmor'
    ];
    List<String> possibleArmorEnchants = ['pArmor', 'mArmor'];

    String enchant = '';

    if (hasAttacks) {
      enchant = possibleWeaponEnchants[
          Random().nextInt(possibleWeaponEnchants.length)];
    } else {
      enchant = possibleWeaponEnchants[
          Random().nextInt(possibleArmorEnchants.length)];
    }

    switch (enchant) {
      case 'pDamage':
        for (Attack attack in enchantedItem.attacks) {
          attack.damage.pDamage += 1;
        }
        break;
      case 'mDamage':
        for (Attack attack in enchantedItem.attacks) {
          attack.damage.mDamage += 1;
        }
        break;
      case 'pArmor':
        item.armor.pArmor += 1;
        break;
      case 'mArmor':
        item.armor.mArmor += 1;
        break;
    }
    enchantedItem.enchanted = true;
    enchantedItem.value += 150;
    return enchantedItem;
  }

  List<Item> lightWeapons = [
    Item(
      name: 'batton',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [
        Attack(
          name: 'jab',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 0, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 7,
            max: 0,
            width: 3.5,
            shape: 'circle',
          ),
          effects: ['stun'],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 1, mArmor: 0),
      enchanted: false,
      weight: 1,
      value: 100,
    ),
    Item(
      name: 'dagger',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [
        Attack(
          name: 'jab',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 1, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 3.5,
            max: 12,
            width: 7,
            shape: 'triangle',
          ),
          effects: ['bleed'],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 1,
      value: 150,
    ),
    Item(
      name: 'flail',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [
        Attack(
          name: 'swing',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 4, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 12,
            max: 13,
            width: 22,
            shape: 'cone',
          ),
          effects: ['vulnerable'],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 5,
      value: 450,
    ),
    Item(
      name: 'gladius',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [
        Attack(
          name: 'slash',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 3, mDamage: 0, rawDamage: 0),
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
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 3,
      value: 300,
    ),
    Item(
      name: 'mace',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [
        Attack(
          name: 'crush',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 2, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 7,
            max: 0,
            width: 3.5,
            shape: 'circle',
          ),
          effects: ['vulnerable'],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 2,
      value: 200,
    ),
    Item(
      name: 'morning star',
      description: '',
      itemSlot: 'one hand',
      effects: [],
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
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 4,
      value: 400,
    ),
    Item(
      name: 'nunchaku',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [
        Attack(
          name: 'swing',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 1, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 3.5,
            max: 6,
            width: 18,
            shape: 'cone',
          ),
          effects: ['stun'],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 1,
      value: 100,
    ),
    Item(
      name: 'poison dagger',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [
        Attack(
          name: 'jab',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 1, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 3.5,
            max: 12,
            width: 7,
            shape: 'triangle',
          ),
          effects: ['bleed', 'poison', 'poison'],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 1,
      value: 350,
    ),
    Item(
      name: 'rapier',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [
        Attack(
          name: 'thrust',
          type: 'melee',
          damage: Damage(pierce: 2, pDamage: 3, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 5,
            max: 20,
            width: 7,
            shape: 'triangle',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 3,
      value: 500,
    ),
    Item(
      name: 'saber',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [
        Attack(
          name: 'slash',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 3, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 5,
            max: 10,
            width: 20,
            shape: 'cone',
          ),
          effects: ['bleed', 'bleed'],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 3,
      value: 500,
    ),
    Item(
      name: 'sharp fist',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [
        Attack(
          name: 'punch',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 1, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 3.5,
            max: 10,
            width: 10,
            shape: 'cone',
          ),
          effects: ['stun'],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 0,
      value: 100,
    ),
    Item(
      name: 'short spear',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [
        Attack(
          name: 'thrust',
          type: 'melee',
          damage: Damage(pierce: 1, pDamage: 2, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 7,
            max: 25,
            width: 7,
            shape: 'triangle',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 3,
      value: 400,
    ),
    Item(
      name: 'short sword',
      description: '',
      itemSlot: 'one hand',
      effects: [],
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
      armor: Armor(pArmor: 2, mArmor: 0),
      enchanted: false,
      weight: 4,
      value: 400,
    ),
    Item(
      name: 'talon',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [
        Attack(
          name: 'thrust',
          type: 'melee',
          damage: Damage(pierce: 1, pDamage: 2, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 3.5,
            max: 15,
            width: 7,
            shape: 'triangle',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 1,
      value: 300,
    ),
    Item(
      name: 'wood axe',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [
        Attack(
          name: 'swing',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 2, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 10,
            max: 11,
            width: 20,
            shape: 'cone',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 2,
      value: 250,
    ),
  ];

  List<Item> heavyWeapons = [
    Item(
      name: 'giant club',
      description: '',
      itemSlot: 'two hands',
      effects: [],
      attacks: [
        Attack(
          name: 'crush',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 6, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 6,
            max: 28,
            width: 8,
            shape: 'cone',
          ),
          effects: ['stun', 'vulnerable'],
          isLoaded: false,
          needsReload: false,
        ),
        Attack(
          name: 'swing',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 4, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 7,
            max: 16,
            width: 25,
            shape: 'cone',
          ),
          effects: ['stun', 'knockback'],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 12,
      value: 400,
    ),
    Item(
      name: 'war hammer',
      description: '',
      itemSlot: 'two hands',
      effects: [],
      attacks: [
        Attack(
          name: 'swing',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 8, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 14.5,
            max: 15.5,
            width: 32,
            shape: 'cone',
          ),
          effects: ['stun', 'knockback'],
          isLoaded: false,
          needsReload: false,
        ),
        Attack(
          name: 'crush',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 10, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 18,
            max: 0,
            width: 3.5,
            shape: 'circle',
          ),
          effects: ['stun', 'stun', 'vulnerable', 'vulnerable'],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 12,
      value: 1000,
    ),
    Item(
      name: 'katana',
      description: '',
      itemSlot: 'two hands',
      effects: [],
      attacks: [
        Attack(
          name: 'swing',
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
        Attack(
          name: 'thrust',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 5, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 7,
            max: 25,
            width: 7,
            shape: 'triangle',
          ),
          effects: ['bleed', 'bleed', 'bleed'],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 4,
      value: 750,
    ),
    Item(
      name: 'long sword',
      description: '',
      itemSlot: 'two hands',
      effects: [],
      attacks: [
        Attack(
          name: 'swing',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 3, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 7,
            max: 10,
            width: 30,
            shape: 'cone',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
        Attack(
          name: 'thrust',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 4, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 7,
            max: 25,
            width: 7,
            shape: 'triangle',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 3, mArmor: 0),
      enchanted: false,
      weight: 6,
      value: 600,
    ),
    Item(
      name: 'battle axe',
      description: '',
      itemSlot: 'two hands',
      effects: [],
      attacks: [
        Attack(
          name: 'swing',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 4, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 9,
            max: 15,
            width: 22,
            shape: 'cone',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
        Attack(
          name: 'slam',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 6, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 13,
            max: 7,
            width: 4,
            shape: 'diamond',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 8,
      value: 600,
    ),
    Item(
      name: 'double sword',
      description: '',
      itemSlot: 'two hands',
      effects: [],
      attacks: [
        Attack(
          name: 'swing',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 3, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 10,
            max: 11,
            width: 20,
            shape: 'cone',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
        Attack(
          name: 'thrust',
          type: 'melee',
          damage: Damage(pierce: 1, pDamage: 4, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 7,
            max: 22.5,
            width: 7,
            shape: 'triangle',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 6,
      value: 650,
    ),
    Item(
      name: 'quarterstaff',
      description: '',
      itemSlot: 'two hands',
      effects: [],
      attacks: [
        Attack(
          name: 'swing',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 0, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 10,
            max: 11,
            width: 20,
            shape: 'double cone',
          ),
          effects: ['knockback'],
          isLoaded: false,
          needsReload: false,
        ),
        Attack(
          name: 'slam',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 1, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 5,
            max: 18,
            width: 4,
            shape: 'rectangle',
          ),
          effects: ['stun'],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 3, mArmor: 0),
      enchanted: false,
      weight: 5,
      value: 500,
    ),
    Item(
      name: 'trident',
      description: '',
      itemSlot: 'two hands',
      effects: [],
      attacks: [
        Attack(
          name: 'thrust',
          type: 'melee',
          damage: Damage(pierce: 2, pDamage: 4, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 15,
            max: 40,
            width: 7,
            shape: 'triangle',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 6,
      value: 800,
    ),
    Item(
      name: 'long spear',
      description: '',
      itemSlot: 'two hands',
      effects: [],
      attacks: [
        Attack(
          name: 'thrust',
          type: 'melee',
          damage: Damage(pierce: 1, pDamage: 3, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 15,
            max: 40,
            width: 7,
            shape: 'triangle',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 1, mArmor: 0),
      enchanted: false,
      weight: 5,
      value: 650,
    ),
    Item(
      name: 'great sword',
      description: '',
      itemSlot: 'two hands',
      effects: [],
      attacks: [
        Attack(
          name: 'swing',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 7, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 10,
            max: 20,
            width: 30,
            shape: 'cone',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
        Attack(
          name: 'slam',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 9, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 8,
            max: 30,
            width: 7,
            shape: 'triangle',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 10,
      value: 900,
    ),
    Item(
      name: 'halberd',
      description: '',
      itemSlot: 'two hands',
      effects: [],
      attacks: [
        Attack(
          name: 'thrust',
          type: 'melee',
          damage: Damage(pierce: 1, pDamage: 5, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 18,
            max: 38,
            width: 10,
            shape: 'triangle',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
        Attack(
          name: 'swing',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 4, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 20,
            max: 24,
            width: 40,
            shape: 'cone',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 8,
      value: 850,
    ),
    Item(
      name: 'long axe',
      description: '',
      itemSlot: 'two hands',
      effects: [],
      attacks: [
        Attack(
          name: 'swing',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 2, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 22,
            max: 18,
            width: 50,
            shape: 'cone',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
        Attack(
          name: 'slam',
          type: 'melee',
          damage: Damage(pierce: 0, pDamage: 4, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 20,
            max: 7,
            width: 4,
            shape: 'diamond',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 7,
      value: 450,
    ),
  ];

  List<Item> rangedWeapons = [
    Item(
      name: 'boomerang',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [
        Attack(
          name: 'throw',
          type: 'ranged',
          damage: Damage(pierce: 0, pDamage: 0, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 20,
            max: 19,
            width: 5,
            shape: 'ring offset',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 1,
      value: 200,
    ),
    Item(
      name: 'kunai',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [
        Attack(
          name: 'throw',
          type: 'ranged',
          damage: Damage(pierce: 0, pDamage: 2, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 7,
            max: 30,
            width: 3.5,
            shape: 'circle',
          ),
          effects: ['bleed'],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 1,
      value: 150,
    ),
    Item(
      name: 'whip',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [
        Attack(
          name: 'whip',
          type: 'ranged',
          damage: Damage(pierce: 0, pDamage: 2, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 23,
            max: 10,
            width: 3.5,
            shape: 'circle',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 2,
      value: 250,
    ),
    Item(
      name: 'poison dart',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [
        Attack(
          name: 'volley',
          type: 'ranged',
          damage: Damage(pierce: 0, pDamage: 0, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 15,
            max: 20,
            width: 3.5,
            shape: 'circle',
          ),
          effects: ['poison', 'poison', 'poison'],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 1,
      value: 350,
    ),
    Item(
      name: 'javelins',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [
        Attack(
          name: 'throw',
          type: 'ranged',
          damage: Damage(pierce: 1, pDamage: 3, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 15,
            max: 30,
            width: 3.5,
            shape: 'circle',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 2,
      value: 300,
    ),
    Item(
      name: 'short bow',
      description: '',
      itemSlot: 'two hands',
      effects: [],
      attacks: [
        Attack(
          name: 'volley',
          type: 'ranged',
          damage: Damage(pierce: 0, pDamage: 3, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 35,
            max: 48,
            width: 3.5,
            shape: 'circle',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 4,
      value: 400,
    ),
    Item(
      name: 'composite bow',
      description: '',
      itemSlot: 'two hands',
      effects: [],
      attacks: [
        Attack(
          name: 'shot',
          type: 'ranged',
          damage: Damage(pierce: 0, pDamage: 4, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 23,
            max: 60,
            width: 3.5,
            shape: 'circle',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 4,
      value: 550,
    ),
    Item(
      name: 'long bow',
      description: '',
      itemSlot: 'two hands',
      effects: [],
      attacks: [
        Attack(
          name: 'volley',
          type: 'ranged',
          damage: Damage(pierce: 0, pDamage: 5, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 50,
            max: 60,
            width: 3.5,
            shape: 'circle',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 6,
      value: 700,
    ),
    Item(
      name: 'hand cannon',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [
        Attack(
          name: 'shot',
          type: 'ranged',
          damage: Damage(pierce: 0, pDamage: 2, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 6,
            max: 28,
            width: 8,
            shape: 'cone',
          ),
          effects: [],
          isLoaded: true,
          needsReload: true,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 2,
      value: 400,
    ),
    Item(
      name: 'hand crossbow',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [
        Attack(
          name: 'volley',
          type: 'ranged',
          damage: Damage(pierce: 0, pDamage: 2, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 5,
            max: 30,
            width: 3.5,
            shape: 'circle',
          ),
          effects: [],
          isLoaded: true,
          needsReload: true,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 2,
      value: 300,
    ),
    Item(
      name: 'light crossbow',
      description: '',
      itemSlot: 'two hands',
      effects: [],
      attacks: [
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
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 4,
      value: 500,
    ),
    Item(
      name: 'heavy crossbow',
      description: '',
      itemSlot: 'two hands',
      effects: [],
      attacks: [
        Attack(
          name: 'shot',
          type: 'ranged',
          damage: Damage(pierce: 0, pDamage: 6, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 7,
            max: 100,
            width: 7,
            shape: 'triangle',
          ),
          effects: ['knockback', 'kickback'],
          isLoaded: true,
          needsReload: true,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 8,
      value: 800,
    ),
    Item(
      name: 'musket',
      description: '',
      itemSlot: 'two hands',
      effects: [],
      attacks: [
        Attack(
          name: 'shot',
          type: 'ranged',
          damage: Damage(pierce: 0, pDamage: 3, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 5,
            max: 80,
            width: 7,
            shape: 'triangle',
          ),
          effects: ['knockback', 'kickback'],
          isLoaded: true,
          needsReload: true,
        ),
        Attack(
          name: 'thrust',
          type: 'ranged',
          damage: Damage(pierce: 1, pDamage: 2, mDamage: 0, rawDamage: 0),
          range: Range(
            min: 7,
            max: 25,
            width: 7,
            shape: 'triangle',
          ),
          effects: [],
          isLoaded: false,
          needsReload: false,
        ),
      ],
      armor: Armor(pArmor: 0, mArmor: 0),
      enchanted: false,
      weight: 6,
      value: 650,
    ),
  ];

  List<Item> magicWeapons = [];

  List<Item> armor = [
    Item(
      name: 'straw hat',
      description: '',
      itemSlot: 'head',
      effects: [],
      attacks: [],
      armor: Armor(pArmor: 1, mArmor: 0),
      enchanted: false,
      weight: 1,
      value: 100,
    ),
    Item(
      name: 'hood',
      description: '',
      itemSlot: 'head',
      effects: [],
      attacks: [],
      armor: Armor(pArmor: 0, mArmor: 1),
      enchanted: false,
      weight: 1,
      value: 100,
    ),
    Item(
      name: 'helmet',
      description: '',
      itemSlot: 'head',
      effects: [],
      attacks: [],
      armor: Armor(pArmor: 2, mArmor: 1),
      enchanted: false,
      weight: 3,
      value: 300,
    ),
    Item(
      name: 'full helmet',
      description: '',
      itemSlot: 'head',
      effects: ['blind'],
      attacks: [],
      armor: Armor(pArmor: 4, mArmor: 0),
      enchanted: false,
      weight: 4,
      value: 350,
    ),
    Item(
      name: 'short gloves',
      description: '',
      itemSlot: 'hands',
      effects: [],
      attacks: [],
      armor: Armor(pArmor: 1, mArmor: 0),
      enchanted: false,
      weight: 0,
      value: 150,
    ),
    Item(
      name: 'leather gloves',
      description: '',
      itemSlot: 'hands',
      effects: [],
      attacks: [],
      armor: Armor(pArmor: 1, mArmor: 1),
      enchanted: false,
      weight: 1,
      value: 250,
    ),
    Item(
      name: 'gauntlet',
      description: '',
      itemSlot: 'hands',
      effects: [],
      attacks: [],
      armor: Armor(pArmor: 2, mArmor: 0),
      enchanted: false,
      weight: 2,
      value: 200,
    ),
    Item(
      name: 'spiky gauntlet',
      description: '',
      itemSlot: 'hands',
      effects: ['spiky'],
      attacks: [],
      armor: Armor(pArmor: 2, mArmor: 0),
      enchanted: false,
      weight: 4,
      value: 300,
    ),
    Item(
      name: 'boots',
      description: '',
      itemSlot: 'feet',
      effects: [],
      attacks: [],
      armor: Armor(pArmor: 2, mArmor: 0),
      enchanted: false,
      weight: 2,
      value: 200,
    ),
    Item(
      name: 'heavy boots',
      description: '',
      itemSlot: 'feet',
      effects: [],
      attacks: [],
      armor: Armor(pArmor: 2, mArmor: 0),
      enchanted: false,
      weight: 2,
      value: 300,
    ),
    Item(
      name: 'sandals',
      description: '',
      itemSlot: 'feet',
      effects: [],
      attacks: [],
      armor: Armor(pArmor: 0, mArmor: 1),
      enchanted: false,
      weight: 0,
      value: 150,
    ),
    Item(
      name: 'shoes',
      description: '',
      itemSlot: 'feet',
      effects: [],
      attacks: [],
      armor: Armor(pArmor: 1, mArmor: 1),
      enchanted: false,
      weight: 1,
      value: 250,
    ),
    Item(
      name: 'light armor',
      description: '',
      itemSlot: 'body',
      effects: [],
      attacks: [],
      armor: Armor(pArmor: 2, mArmor: 0),
      enchanted: false,
      weight: 1,
      value: 250,
    ),
    Item(
      name: 'heavy armor',
      description: '',
      itemSlot: 'body',
      effects: [],
      attacks: [],
      armor: Armor(pArmor: 5, mArmor: 0),
      enchanted: false,
      weight: 5,
      value: 500,
    ),
    Item(
      name: 'robe',
      description: '',
      itemSlot: 'body',
      effects: [],
      attacks: [],
      armor: Armor(pArmor: 1, mArmor: 2),
      enchanted: false,
      weight: 2,
      value: 350,
    ),
    Item(
      name: 'battle robe',
      description: '',
      itemSlot: 'body',
      effects: [],
      attacks: [],
      armor: Armor(pArmor: 1, mArmor: 4),
      enchanted: false,
      weight: 3,
      value: 600,
    ),
    Item(
      name: 'wooden shield',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [],
      armor: Armor(pArmor: 2, mArmor: 0),
      enchanted: false,
      weight: 2,
      value: 200,
    ),
    Item(
      name: 'spiky shield',
      description: '',
      itemSlot: 'one hand',
      effects: ['spiky'],
      attacks: [],
      armor: Armor(pArmor: 3, mArmor: 0),
      enchanted: false,
      weight: 3,
      value: 400,
    ),
    Item(
      name: 'magic shield',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [],
      armor: Armor(pArmor: 2, mArmor: 2),
      enchanted: false,
      weight: 4,
      value: 400,
    ),
    Item(
      name: 'heavy shield',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [],
      armor: Armor(pArmor: 4, mArmor: 2),
      enchanted: false,
      weight: 6,
      value: 600,
    ),
    Item(
      name: 'protective charm',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [],
      armor: Armor(pArmor: 0, mArmor: 1),
      enchanted: false,
      weight: 0,
      value: 150,
    ),
    Item(
      name: 'dream catcher',
      description: '',
      itemSlot: 'one hand',
      effects: [],
      attacks: [],
      armor: Armor(pArmor: 0, mArmor: 3),
      enchanted: false,
      weight: 1,
      value: 400,
    ),
  ];

  List<Item> ancient = [];

  List<Item> consumables = [
    Item(
      name: 'invisibility potion',
      description: '',
      itemSlot: 'consumable',
      effects: [],
      attacks: [],
      armor: Armor.empty(),
      enchanted: false,
      weight: 1,
      value: 100,
    ),
    Item(
      name: 'cleansing potion',
      description: '',
      itemSlot: 'consumable',
      effects: [],
      attacks: [],
      armor: Armor.empty(),
      enchanted: false,
      weight: 1,
      value: 100,
    ),
    Item(
      name: 'healing potion',
      description: '',
      itemSlot: 'consumable',
      effects: [],
      attacks: [],
      armor: Armor.empty(),
      enchanted: false,
      weight: 1,
      value: 200,
    ),
    Item(
      name: 'bandages',
      description: '',
      itemSlot: 'consumable',
      effects: [],
      attacks: [],
      armor: Armor.empty(),
      enchanted: false,
      weight: 1,
      value: 50,
    ),
    Item(
      name: 'food',
      description: '',
      itemSlot: 'consumable',
      effects: [],
      attacks: [],
      armor: Armor.empty(),
      enchanted: false,
      weight: 1,
      value: 50,
    ),
    Item(
      name: 'key',
      description: '',
      itemSlot: 'key',
      effects: [],
      attacks: [],
      armor: Armor.empty(),
      enchanted: false,
      weight: 1,
      value: 50,
    ),
    Item(
      name: 'antidote',
      description: '',
      itemSlot: 'consumable',
      effects: [],
      attacks: [],
      armor: Armor.empty(),
      enchanted: false,
      weight: 1,
      value: 50,
    ),
  ];
}
