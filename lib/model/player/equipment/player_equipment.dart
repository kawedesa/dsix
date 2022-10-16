import 'package:dsix/model/item/item.dart';
import 'player_armor.dart';
import 'player_damage.dart';
import 'player_attack_range.dart';
import 'player_equipment_slot.dart';

class PlayerEquipment {
  PlayerArmor armor;
  PlayerDamage damage;
  PlayerAttackRange attackRange;
  PlayerEquipmentSlot mainHandSlot;
  PlayerEquipmentSlot offHandSlot;
  PlayerEquipmentSlot headSlot;
  PlayerEquipmentSlot bodySlot;
  PlayerEquipmentSlot handSlot;
  PlayerEquipmentSlot feetSlot;
  List<Item> bag;
  int maxWeight;
  int currentWeight;
  int money;
  PlayerEquipment({
    required this.armor,
    required this.damage,
    required this.attackRange,
    required this.mainHandSlot,
    required this.offHandSlot,
    required this.headSlot,
    required this.bodySlot,
    required this.handSlot,
    required this.feetSlot,
    required this.bag,
    required this.maxWeight,
    required this.currentWeight,
    required this.money,
  });

  factory PlayerEquipment.empty() {
    return PlayerEquipment(
      armor: PlayerArmor.empty(),
      damage: PlayerDamage.empty(),
      attackRange: PlayerAttackRange.empty(),
      mainHandSlot: PlayerEquipmentSlot.empty('mainHandSlot'),
      offHandSlot: PlayerEquipmentSlot.empty('offHandSlot'),
      headSlot: PlayerEquipmentSlot.empty('headSlot'),
      bodySlot: PlayerEquipmentSlot.empty('bodySlot'),
      handSlot: PlayerEquipmentSlot.empty('handSlot'),
      feetSlot: PlayerEquipmentSlot.empty('feetSlot'),
      bag: [],
      maxWeight: 0,
      currentWeight: 0,
      money: 300,
    );
  }

  factory PlayerEquipment.fromMap(Map<String, dynamic>? data) {
    List<Item> bag = [];
    List<dynamic> bagMap = data?['bag'];

    for (var item in bagMap) {
      bag.add(Item.fromMap(item));
    }

    return PlayerEquipment(
      armor: PlayerArmor.fromMap(data?['armor']),
      damage: PlayerDamage.fromMap(data?['damage']),
      attackRange: PlayerAttackRange.fromMap(data?['attackRange']),
      mainHandSlot: PlayerEquipmentSlot.fromMap(data?['mainHandSlot']),
      offHandSlot: PlayerEquipmentSlot.fromMap(data?['offHandSlot']),
      headSlot: PlayerEquipmentSlot.fromMap(data?['headSlot']),
      bodySlot: PlayerEquipmentSlot.fromMap(data?['bodySlot']),
      handSlot: PlayerEquipmentSlot.fromMap(data?['handSlot']),
      feetSlot: PlayerEquipmentSlot.fromMap(data?['feetSlot']),
      bag: bag,
      maxWeight: data?['maxWeight'],
      currentWeight: data?['currentWeight'],
      money: data?['money'],
    );
  }

  Map<String, dynamic> toMap() {
    var bag = this.bag.map((item) => item.toMap()).toList();
    return {
      'armor': armor.toMap(),
      'damage': damage.toMap(),
      'attackRange': attackRange.toMap(),
      'mainHandSlot': mainHandSlot.toMap(),
      'offHandSlot': offHandSlot.toMap(),
      'headSlot': headSlot.toMap(),
      'bodySlot': bodySlot.toMap(),
      'handSlot': handSlot.toMap(),
      'feetSlot': feetSlot.toMap(),
      'bag': bag,
      'maxWeight': maxWeight,
      'currentWeight': currentWeight,
      'money': money,
    };
  }

  void setWeight(String race) {
    if (race == 'orc') {
      maxWeight = 20;
    } else {
      maxWeight = 15;
    }
  }

  void getItem(Item item) {
    currentWeight += item.weight;
    bag.add(item);
  }

  bool notEnoughMoney(int itemValue) {
    if (itemValue > money) {
      return true;
    } else {
      return false;
    }
  }

  bool tooHeavy(int itemWeight) {
    if (itemWeight > maxWeight - currentWeight) {
      return true;
    } else {
      return false;
    }
  }
}
