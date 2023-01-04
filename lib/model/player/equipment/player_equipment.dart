import 'package:dsix/model/item/item.dart';
import 'player_armor.dart';
import 'player_damage.dart';
import 'player_attack_range.dart';
import 'equipment_slot.dart';

class PlayerEquipment {
  PlayerArmor armor;
  PlayerDamage damage;
  PlayerAttackRange attackRange;
  EquipmentSlot mainHandSlot;
  EquipmentSlot offHandSlot;
  EquipmentSlot headSlot;
  EquipmentSlot bodySlot;
  EquipmentSlot handSlot;
  EquipmentSlot feetSlot;
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
      mainHandSlot: EquipmentSlot.empty('mainHandSlot'),
      offHandSlot: EquipmentSlot.empty('offHandSlot'),
      headSlot: EquipmentSlot.empty('headSlot'),
      bodySlot: EquipmentSlot.empty('bodySlot'),
      handSlot: EquipmentSlot.empty('handSlot'),
      feetSlot: EquipmentSlot.empty('feetSlot'),
      bag: [],
      maxWeight: 0,
      currentWeight: 0,
      money: 1000,
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
      mainHandSlot: EquipmentSlot.fromMap(data?['mainHandSlot']),
      offHandSlot: EquipmentSlot.fromMap(data?['offHandSlot']),
      headSlot: EquipmentSlot.fromMap(data?['headSlot']),
      bodySlot: EquipmentSlot.fromMap(data?['bodySlot']),
      handSlot: EquipmentSlot.fromMap(data?['handSlot']),
      feetSlot: EquipmentSlot.fromMap(data?['feetSlot']),
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

  void equip(EquipmentSlot slot, Item item) {
    increaseDamageAndArmor(item);

    if (item.itemSlot == 'two hands') {
      unequip(mainHandSlot);
      unequip(offHandSlot);
      mainHandSlot.item = item;
      offHandSlot.item = item;
    } else {
      unequip(slot);
      slot.item = item;
    }
  }

  void switchEquipments() {
    Item tempItem = mainHandSlot.item;
    mainHandSlot.item = offHandSlot.item;
    offHandSlot.item = tempItem;
  }

  void unequip(EquipmentSlot slot) {
    if (slot.isEmpty()) {
      return;
    }

    decreaseDamageAndArmor(slot.item);
    bag.add(slot.item);

    if (slot.item.itemSlot == 'two hands') {
      mainHandSlot.unequip();
      offHandSlot.unequip();
    } else {
      slot.unequip();
    }
  }

  void increaseDamageAndArmor(Item item) {
    damage.increaseDamage(item);
    armor.increaseArmor(item);
    attackRange.increase(item);
  }

  void decreaseDamageAndArmor(Item item) {
    damage.decreaseDamage(item);
    armor.decreaseArmor(item);
    attackRange.decrease(item);
  }

  void removeItemfromBag(Item item) {
    bag.remove(item);
  }

  void addItemToBag(Item item) {
    bag.add(item);
  }

  void sellItem(EquipmentSlot slot) {
    Item tempItem = slot.item;

    if (slot.name != 'bag') {
      unequip(slot);
    }
    removeItemfromBag(tempItem);
    money += tempItem.value ~/ 2;
  }

  void useItem(EquipmentSlot slot) {}
}
