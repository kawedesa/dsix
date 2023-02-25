import 'package:dsix/model/combat/armor.dart';
import 'package:dsix/model/item/item.dart';
import 'package:dsix/shared/app_exceptions.dart';
import '../../combat/damage.dart';
import 'equipment_slot.dart';

class PlayerEquipment {
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

    bag.add(slot.item);

    if (slot.item.itemSlot == 'two hands') {
      mainHandSlot.unequip();
      offHandSlot.unequip();
    } else {
      slot.unequip();
    }
  }

  void removeItemfromBag(Item item) {
    bag.remove(item);
  }

  void buyItem(Item item) {
    money -= item.value;
    currentWeight += item.weight;
    bag.add(item);
  }

  void sellItem(EquipmentSlot slot) {
    Item tempItem = slot.item;
    int itemValue = tempItem.value ~/ 2;

    if (slot.name != 'bag') {
      unequip(slot);
    }

    money += itemValue;
    currentWeight -= tempItem.weight;
    removeItemfromBag(tempItem);

    throw ItemSoldException('+ \$$itemValue');
  }

  void useItem(EquipmentSlot slot) {}

  int calculateDamage(Damage rawDamage) {
    int pDamage = rawDamage.pDamage - getTotalArmor().pArmor;
    if (pDamage < 0) {
      pDamage = 0;
    }
    int mDamage = rawDamage.mDamage - getTotalArmor().mArmor;
    if (mDamage < 0) {
      mDamage = 0;
    }

    int totalDamage = pDamage + mDamage;

    print(totalDamage);

    return totalDamage;
  }

  Armor getTotalArmor() {
    int pArmor = 0;
    int mArmor = 0;

    pArmor = mainHandSlot.item.armor.pArmor +
        offHandSlot.item.armor.pArmor +
        headSlot.item.armor.pArmor +
        bodySlot.item.armor.pArmor +
        handSlot.item.armor.pArmor +
        feetSlot.item.armor.pArmor;
    mArmor = mainHandSlot.item.armor.mArmor +
        offHandSlot.item.armor.mArmor +
        headSlot.item.armor.mArmor +
        bodySlot.item.armor.mArmor +
        handSlot.item.armor.mArmor +
        feetSlot.item.armor.mArmor;

    return Armor(pArmor: pArmor, mArmor: mArmor);
  }
}
