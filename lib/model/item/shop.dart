import 'package:dsix/shared/app_images.dart';
import 'dart:math';
import 'item.dart';

class Shop {
  Item randomItem() {
    late Item newItem;
    late int randomItem;
    switch (randomCategory()) {
      case 'meleeWeapons':
        randomItem = Random().nextInt(meleeWeapons.length);
        newItem = meleeWeapons[randomItem];
        break;

      case 'rangedWeapons':
        randomItem = Random().nextInt(rangedWeapons.length);
        newItem = rangedWeapons[randomItem];
        break;

      case 'armor':
        randomItem = Random().nextInt(armor.length);
        newItem = armor[randomItem];
        break;
      case 'ancient':
        randomItem = Random().nextInt(ancient.length);
        newItem = ancient[randomItem];
        break;
      case 'consumable':
        randomItem = Random().nextInt(consumable.length);
        newItem = consumable[randomItem];
        break;
    }
    return newItem;
  }

  String randomCategory() {
    List<String> category = [
      'meleeWeapons',
      'rangedWeapons',
      'armor',
      'ancient',
      'consumable',
    ];
    int randomCategory = Random().nextInt(category.length);
    return category[randomCategory];
  }

  List<Item> meleeWeapons = [
    Item(
      icon: AppImages.baton,
      name: 'baton',
      description: '',
      itemSlot: 'one hand',
      type: 'melee',
      pDamage: 0,
      pArmor: 1,
      mDamage: 0,
      mArmor: 0,
      weight: 1,
      value: 100,
      maxRange: 5,
      minRange: 0,
    ),
    Item(
      icon: AppImages.dagger,
      name: 'dagger',
      description: '',
      itemSlot: 'one hand',
      type: 'melee',
      pDamage: 1,
      mDamage: 0,
      pArmor: 0,
      mArmor: 0,
      weight: 1,
      value: 100,
      maxRange: 5,
      minRange: 0,
    ),
    Item(
      icon: AppImages.mace,
      name: 'mace',
      description: '',
      itemSlot: 'one hand',
      type: 'melee',
      pDamage: 2,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 3,
      value: 100,
      maxRange: 10,
      minRange: 0,
    ),
    Item(
      icon: AppImages.claw,
      name: 'claw',
      description: '',
      itemSlot: 'one hand',
      type: 'melee',
      pDamage: 1,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 0,
      value: 200,
      maxRange: 5,
      minRange: 0,
    ),
    Item(
      icon: AppImages.axe,
      name: 'axe',
      description: '',
      itemSlot: 'one hand',
      type: 'melee',
      pDamage: 2,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 2,
      value: 200,
      maxRange: 10,
      minRange: 0,
    ),
    Item(
      icon: AppImages.shortSword,
      name: 'short sword',
      description: '',
      itemSlot: 'one hand',
      type: 'melee',
      pDamage: 1,
      pArmor: 1,
      mDamage: 0,
      mArmor: 0,
      weight: 1,
      value: 300,
      maxRange: 10,
      minRange: 0,
    ),
    Item(
      icon: AppImages.ritualDagger,
      name: 'ritual dagger',
      description: '',
      itemSlot: 'one hand',
      type: 'melee',
      pDamage: 1,
      pArmor: 0,
      mDamage: 1,
      mArmor: 0,
      weight: 2,
      value: 300,
      maxRange: 10,
      minRange: 0,
    ),
    Item(
      icon: AppImages.shortSpear,
      name: 'short spear',
      description: '',
      itemSlot: 'one hand',
      type: 'melee',
      pDamage: 2,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 1,
      value: 300,
      maxRange: 15,
      minRange: 0,
    ),
    Item(
      icon: AppImages.longSpear,
      name: 'long spear',
      description: '',
      itemSlot: 'two hands',
      type: 'melee',
      pDamage: 3,
      mDamage: 0,
      pArmor: 0,
      mArmor: 0,
      weight: 2,
      value: 300,
      maxRange: 30,
      minRange: 40,
    ),
    Item(
      icon: AppImages.quarterstaff,
      name: 'quarterstaff',
      description: '',
      itemSlot: 'two hands',
      type: 'melee',
      pDamage: 1,
      pArmor: 3,
      mDamage: 0,
      mArmor: 0,
      weight: 4,
      value: 300,
      maxRange: 20,
      minRange: 30,
    ),
    Item(
      icon: AppImages.rapier,
      name: 'rapier',
      description: '',
      itemSlot: 'one hand',
      type: 'melee',
      pDamage: 3,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 2,
      value: 400,
      maxRange: 10,
      minRange: 0,
    ),
    Item(
      icon: AppImages.sword,
      name: 'sword',
      description: '',
      itemSlot: 'one hand',
      type: 'melee',
      pDamage: 2,
      pArmor: 2,
      mDamage: 0,
      mArmor: 0,
      weight: 4,
      value: 400,
      maxRange: 10,
      minRange: 0,
    ),
    Item(
      icon: AppImages.magicSword,
      name: 'magic sword',
      description: '',
      itemSlot: 'one hand',
      type: 'melee',
      pDamage: 1,
      pArmor: 1,
      mDamage: 1,
      mArmor: 0,
      weight: 3,
      value: 400,
      maxRange: 15,
      minRange: 0,
    ),
    Item(
      icon: AppImages.doubleSword,
      name: 'double sword',
      description: '',
      itemSlot: 'two hands',
      type: 'melee',
      pDamage: 5,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 5,
      value: 400,
      maxRange: 25,
      minRange: 35,
    ),
    Item(
      icon: AppImages.trident,
      name: 'trident',
      description: '',
      itemSlot: 'two hands',
      type: 'melee',
      pDamage: 4,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 3,
      value: 400,
      maxRange: 30,
      minRange: 40,
    ),
    Item(
      icon: AppImages.morningStar,
      name: 'morningStar',
      description: '',
      itemSlot: 'one hand',
      type: 'melee',
      pDamage: 5,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 6,
      value: 400,
      maxRange: 10,
      minRange: 0,
    ),
    Item(
      icon: AppImages.saber,
      name: 'saber',
      description: '',
      itemSlot: 'one hand',
      type: 'melee',
      pDamage: 4,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 3,
      value: 500,
      maxRange: 10,
      minRange: 0,
    ),
    Item(
      icon: AppImages.longSword,
      name: 'long sword',
      description: '',
      itemSlot: 'one hand',
      type: 'melee',
      pDamage: 3,
      pArmor: 2,
      mDamage: 0,
      mArmor: 0,
      weight: 5,
      value: 500,
      maxRange: 15,
      minRange: 0,
    ),
    Item(
      icon: AppImages.battleAxe,
      name: 'battle axe',
      description: '',
      itemSlot: 'two hands',
      type: 'melee',
      pDamage: 7,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 8,
      value: 500,
      maxRange: 20,
      minRange: 30,
    ),
    Item(
      icon: AppImages.halberd,
      name: 'halberd',
      description: '',
      itemSlot: 'two hands',
      type: 'melee',
      pDamage: 6,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 6,
      value: 500,
      maxRange: 30,
      minRange: 40,
    ),
    Item(
      icon: AppImages.magicAxe,
      name: 'magic axe',
      description: '',
      itemSlot: 'one hand',
      type: 'melee',
      pDamage: 2,
      pArmor: 0,
      mDamage: 2,
      mArmor: 0,
      weight: 4,
      value: 600,
      maxRange: 10,
      minRange: 0,
    ),
    Item(
      icon: AppImages.warHammer,
      name: 'war hammer',
      description: '',
      itemSlot: 'two hands',
      type: 'melee',
      pDamage: 8,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 9,
      value: 600,
      maxRange: 20,
      minRange: 30,
    ),
    Item(
      icon: AppImages.greatSword,
      name: 'great sword',
      description: '',
      itemSlot: 'two hands',
      type: 'melee',
      pDamage: 5,
      pArmor: 2,
      mDamage: 0,
      mArmor: 0,
      weight: 7,
      value: 600,
      maxRange: 25,
      minRange: 35,
    ),
  ];

  List<Item> rangedWeapons = [
    Item(
      icon: AppImages.blowgun,
      name: 'blowgun',
      description: '',
      itemSlot: 'two hands',
      type: 'ranged',
      pDamage: 1,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 0,
      value: 100,
      maxRange: 60,
      minRange: 50,
    ),
    Item(
      icon: AppImages.boomerang,
      name: 'boomerang',
      description: '',
      itemSlot: 'one hand',
      type: 'ranged',
      pDamage: 1,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 1,
      value: 100,
      maxRange: 40,
      minRange: 30,
    ),
    Item(
      icon: AppImages.javelins,
      name: 'javelins',
      description: '',
      itemSlot: 'one hand',
      type: 'ranged',
      pDamage: 2,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 1,
      value: 200,
      maxRange: 40,
      minRange: 30,
    ),
    Item(
      icon: AppImages.grenades,
      name: 'grenades',
      description: '',
      itemSlot: 'one hand',
      type: 'ranged',
      pDamage: 0,
      pArmor: 0,
      mDamage: 2,
      mArmor: 0,
      weight: 1,
      value: 200,
      maxRange: 40,
      minRange: 30,
    ),
    Item(
      icon: AppImages.magicOrb,
      name: 'magic orb',
      description: '',
      itemSlot: 'one hand',
      type: 'ranged',
      pDamage: 0,
      pArmor: 0,
      mDamage: 1,
      mArmor: 0,
      weight: 1,
      value: 200,
      maxRange: 10,
      minRange: 0,
    ),
    Item(
      icon: AppImages.wand,
      name: 'wand',
      description: '',
      itemSlot: 'one hand',
      type: 'ranged',
      pDamage: 0,
      pArmor: 0,
      mDamage: 1,
      mArmor: 0,
      weight: 0,
      value: 300,
      maxRange: 20,
      minRange: 0,
    ),
    Item(
      icon: AppImages.shortBow,
      name: 'short bow',
      description: '',
      itemSlot: 'two hands',
      type: 'ranged',
      pDamage: 3,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 3,
      value: 300,
      maxRange: 80,
      minRange: 70,
    ),
    Item(
      icon: AppImages.kunai,
      name: 'kunai',
      description: '',
      itemSlot: 'one hand',
      type: 'ranged',
      pDamage: 2,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 1,
      value: 300,
      maxRange: 40,
      minRange: 30,
    ),
    Item(
      icon: AppImages.handCrossbow,
      name: 'hand crossbow',
      description: '',
      itemSlot: 'one hand',
      type: 'ranged',
      pDamage: 2,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 2,
      value: 400,
      maxRange: 40,
      minRange: 30,
    ),
    Item(
      icon: AppImages.longBow,
      name: 'long bow',
      description: '',
      itemSlot: 'two hands',
      type: 'ranged',
      pDamage: 4,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 4,
      value: 400,
      maxRange: 120,
      minRange: 80,
    ),
    Item(
      icon: AppImages.spellBook,
      name: 'spellBook',
      description: '',
      itemSlot: 'one hand',
      type: 'ranged',
      pDamage: 0,
      pArmor: 0,
      mDamage: 2,
      mArmor: 0,
      weight: 1,
      value: 500,
      maxRange: 30,
      minRange: 0,
    ),
    Item(
      icon: AppImages.greatBow,
      name: 'great bow',
      description: '',
      itemSlot: 'two hands',
      type: 'ranged',
      pDamage: 5,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 5,
      value: 500,
      maxRange: 160,
      minRange: 90,
    ),
    Item(
      icon: AppImages.lightCrossbow,
      name: 'light crossbow',
      description: '',
      itemSlot: 'two hands',
      type: 'ranged',
      pDamage: 4,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 3,
      value: 500,
      maxRange: 80,
      minRange: 70,
    ),
    Item(
      icon: AppImages.handCannon,
      name: 'hand cannon',
      description: '',
      itemSlot: 'one hand',
      type: 'ranged',
      pDamage: 3,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 0,
      value: 600,
      maxRange: 40,
      minRange: 30,
    ),
    Item(
      icon: AppImages.heavyCrossbow,
      name: 'heavy crossbow',
      description: '',
      itemSlot: 'two hands',
      type: 'ranged',
      pDamage: 7,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 8,
      value: 600,
      maxRange: 120,
      minRange: 80,
    ),
    Item(
      icon: AppImages.magicStaff,
      name: 'magic staff',
      description: '',
      itemSlot: 'two hands',
      type: 'ranged',
      pDamage: 0,
      pArmor: 0,
      mDamage: 5,
      mArmor: 0,
      weight: 5,
      value: 700,
      maxRange: 50,
      minRange: 0,
    ),
    Item(
      icon: AppImages.musket,
      name: 'musket',
      description: '',
      itemSlot: 'two hands',
      type: 'ranged',
      pDamage: 5,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      weight: 3,
      value: 700,
      maxRange: 60,
      minRange: 50,
    ),
  ];

  List<Item> armor = [
    Item(
      icon: AppImages.boots,
      name: 'boots',
      description: '',
      itemSlot: 'feet',
      type: 'armor',
      pDamage: 0,
      pArmor: 1,
      mDamage: 0,
      mArmor: 0,
      weight: 1,
      value: 100,
      maxRange: 0,
      minRange: 0,
    ),
    Item(
      icon: AppImages.gloves,
      name: 'gloves',
      description: '',
      itemSlot: 'hands',
      type: 'armor',
      pDamage: 0,
      pArmor: 1,
      mDamage: 0,
      mArmor: 0,
      weight: 1,
      value: 100,
      maxRange: 0,
      minRange: 0,
    ),
    Item(
      icon: AppImages.buckler,
      name: 'buckler',
      description: '',
      itemSlot: 'one hand',
      type: 'armor',
      pDamage: 0,
      pArmor: 1,
      mDamage: 0,
      mArmor: 0,
      weight: 0,
      value: 200,
      maxRange: 0,
      minRange: 0,
    ),
    Item(
      icon: AppImages.magicSandals,
      name: 'magic sandals',
      description: '',
      itemSlot: 'feet',
      type: 'armor',
      pDamage: 0,
      pArmor: 0,
      mDamage: 0,
      mArmor: 1,
      weight: 1,
      value: 200,
      maxRange: 0,
      minRange: 0,
    ),
    Item(
      icon: AppImages.helmet,
      name: 'helmet',
      description: '',
      itemSlot: 'head',
      type: 'armor',
      pDamage: 0,
      pArmor: 2,
      mDamage: 0,
      mArmor: 0,
      weight: 1,
      value: 300,
      maxRange: 0,
      minRange: 0,
    ),
    Item(
      icon: AppImages.lightShield,
      name: 'light shield',
      description: '',
      itemSlot: 'one hand',
      type: 'armor',
      pDamage: 0,
      pArmor: 2,
      mDamage: 0,
      mArmor: 0,
      weight: 1,
      value: 300,
      maxRange: 0,
      minRange: 0,
    ),
    Item(
      icon: AppImages.lightArmor,
      name: 'light armor',
      description: '',
      itemSlot: 'body',
      type: 'armor',
      pDamage: 0,
      pArmor: 4,
      mDamage: 0,
      mArmor: 0,
      weight: 4,
      value: 400,
      maxRange: 0,
      minRange: 0,
    ),
    Item(
      icon: AppImages.magicRobe,
      name: 'magic robe',
      description: '',
      itemSlot: 'body',
      type: 'armor',
      pDamage: 0,
      pArmor: 0,
      mDamage: 0,
      mArmor: 2,
      weight: 2,
      value: 400,
      maxRange: 0,
      minRange: 0,
    ),
    Item(
      icon: AppImages.heavyShield,
      name: 'heavy shield',
      description: '',
      itemSlot: 'one hand',
      type: 'armor',
      pDamage: 0,
      pArmor: 4,
      mDamage: 0,
      mArmor: 0,
      weight: 3,
      value: 500,
      maxRange: 0,
      minRange: 0,
    ),
    Item(
      icon: AppImages.fullHelmet,
      name: 'full helmet',
      description: '',
      itemSlot: 'head',
      type: 'armor',
      pDamage: 0,
      pArmor: 4,
      mDamage: 0,
      mArmor: 0,
      weight: 2,
      value: 600,
      maxRange: 0,
      minRange: 0,
    ),
    Item(
      icon: AppImages.magicShield,
      name: 'magic shield',
      description: '',
      itemSlot: 'one hand',
      type: 'armor',
      pDamage: 0,
      pArmor: 0,
      mDamage: 0,
      mArmor: 3,
      weight: 3,
      value: 600,
      maxRange: 0,
      minRange: 0,
    ),
    Item(
      icon: AppImages.heavyArmor,
      name: 'heavy armor',
      description: '',
      itemSlot: 'body',
      type: 'armor',
      pDamage: 0,
      pArmor: 7,
      mDamage: 0,
      mArmor: 0,
      weight: 7,
      value: 700,
      maxRange: 0,
      minRange: 0,
    ),
  ];

  List<Item> ancient = [
    Item(
      icon: AppImages.ancientSword,
      name: 'ancient sword',
      description: '',
      itemSlot: 'one hand',
      type: 'melee',
      pDamage: 3,
      pArmor: 0,
      mDamage: 2,
      mArmor: 0,
      weight: 2,
      value: 1600,
      maxRange: 15,
      minRange: 0,
    ),
    Item(
      icon: AppImages.ancientWarAxe,
      name: 'ancient war axe',
      description: '',
      itemSlot: 'two hands',
      type: 'melee',
      pDamage: 6,
      pArmor: 0,
      mDamage: 2,
      mArmor: 0,
      weight: 4,
      value: 1700,
      maxRange: 20,
      minRange: 25,
    ),
    Item(
      icon: AppImages.ancientBow,
      name: 'ancient bow',
      description: '',
      itemSlot: 'two hands',
      type: 'ranged',
      pDamage: 4,
      pArmor: 0,
      mDamage: 2,
      mArmor: 0,
      weight: 1,
      value: 1600,
      maxRange: 250,
      minRange: 90,
    ),
    Item(
      icon: AppImages.ancientSpellBook,
      name: 'ancient spellbook',
      description: '',
      itemSlot: 'one hand',
      type: 'ranged',
      pDamage: 0,
      pArmor: 0,
      mDamage: 6,
      mArmor: 0,
      weight: 2,
      value: 1900,
      maxRange: 40,
      minRange: 0,
    ),
    Item(
      icon: AppImages.ancientGloves,
      name: 'ancient gloves',
      description: '',
      itemSlot: 'hands',
      type: 'armor',
      pDamage: 0,
      pArmor: 1,
      mDamage: 0,
      mArmor: 1,
      weight: 0,
      value: 800,
      maxRange: 0,
      minRange: 0,
    ),
    Item(
      icon: AppImages.ancientBoots,
      name: 'ancient boots',
      description: '',
      itemSlot: 'feet',
      type: 'armor',
      pDamage: 0,
      pArmor: 2,
      mDamage: 0,
      mArmor: 1,
      weight: 1,
      value: 900,
      maxRange: 0,
      minRange: 0,
    ),
    Item(
      icon: AppImages.ancientHelmet,
      name: 'ancient helmet',
      description: '',
      itemSlot: 'head',
      type: 'armor',
      pDamage: 0,
      pArmor: 4,
      mDamage: 0,
      mArmor: 2,
      weight: 2,
      value: 1200,
      maxRange: 0,
      minRange: 0,
    ),
    Item(
      icon: AppImages.ancientShield,
      name: 'ancient shield',
      description: '',
      itemSlot: 'one hand',
      type: 'armor',
      pDamage: 0,
      pArmor: 3,
      mDamage: 0,
      mArmor: 2,
      weight: 2,
      value: 1600,
      maxRange: 0,
      minRange: 0,
    ),
    Item(
      icon: AppImages.ancientArmor,
      name: 'ancient armor',
      description: '',
      itemSlot: 'body',
      type: 'armor',
      pDamage: 0,
      pArmor: 5,
      mDamage: 0,
      mArmor: 2,
      weight: 3,
      value: 1600,
      maxRange: 0,
      minRange: 0,
    ),
  ];

  List<Item> consumable = [
    Item(
      icon: AppImages.ward,
      name: 'ward',
      description: 'Reveals an area around you',
      itemSlot: 'consumable',
      type: 'consumable',
      weight: 1,
      value: 100,
      pDamage: 0,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      maxRange: 0,
      minRange: 0,
    ),
    Item(
      icon: AppImages.food,
      name: 'food',
      description: 'Heals 1-3 HP',
      itemSlot: 'consumable',
      type: 'consumable',
      weight: 1,
      value: 100,
      pDamage: 0,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      maxRange: 0,
      minRange: 0,
    ),
    Item(
      icon: AppImages.healingPotion,
      name: 'healing potion',
      description: 'Heals 3-6 HP',
      itemSlot: 'consumable',
      type: 'consumable',
      weight: 1,
      value: 300,
      pDamage: 0,
      pArmor: 0,
      mDamage: 0,
      mArmor: 0,
      maxRange: 0,
      minRange: 0,
    ),
  ];
}
