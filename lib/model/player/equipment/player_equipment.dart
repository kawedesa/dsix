import 'package:dsix/model/combat/armor.dart';
import 'package:dsix/model/item/item.dart';
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
  int gold;
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
    required this.gold,
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
      gold: 500,
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
      gold: data?['gold'],
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
      'gold': gold,
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
    if (itemValue > gold) {
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

  void addGold(int value) {
    gold += value;
  }

  void removeGold(int value) {
    gold -= value;
  }

  void switchEquipments() {
    Item tempItem = mainHandSlot.item;
    mainHandSlot.item = offHandSlot.item;
    offHandSlot.item = tempItem;
  }

  void removeItemWeight(int weight) {
    currentWeight -= weight;
  }

  void addItemWeight(int weight) {
    currentWeight += weight;
  }

  void addItemToBag(Item item) {
    bag.add(item);
  }

  void removeItemFromBag(Item item) {
    bag.remove(item);
  }

  void useItem(EquipmentSlot slot) {}

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

  int getPArmor() {
    int pArmor = 0;

    pArmor = mainHandSlot.item.armor.pArmor +
        offHandSlot.item.armor.pArmor +
        headSlot.item.armor.pArmor +
        bodySlot.item.armor.pArmor +
        handSlot.item.armor.pArmor +
        feetSlot.item.armor.pArmor;

    return pArmor;
  }

  int getMArmor() {
    int mArmor = 0;

    mArmor = mainHandSlot.item.armor.mArmor +
        offHandSlot.item.armor.mArmor +
        headSlot.item.armor.mArmor +
        bodySlot.item.armor.mArmor +
        handSlot.item.armor.mArmor +
        feetSlot.item.armor.mArmor;

    return mArmor;
  }
}
