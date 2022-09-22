import 'package:dsix/model/item/item.dart';

class PlayerEquipmentSlot {
  String name;
  Item item;
  PlayerEquipmentSlot({required this.name, required this.item});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'item': item.toMap(),
    };
  }

  factory PlayerEquipmentSlot.fromMap(Map<String, dynamic>? data) {
    return PlayerEquipmentSlot(
      name: data?['name'],
      item: Item.fromMap(data?['item']),
    );
  }

  factory PlayerEquipmentSlot.fromItem(String slotName, Item item) {
    return PlayerEquipmentSlot(
      name: slotName,
      item: item,
    );
  }

  factory PlayerEquipmentSlot.empty(String slotName) {
    return PlayerEquipmentSlot(
      name: slotName,
      item: Item.empty(),
    );
  }

  bool isEmpty() {
    if (item.name == '') {
      return true;
    }
    return false;
  }

  void equip(PlayerEquipmentSlot equipmentSlot) {
    name = equipmentSlot.name;
    item = equipmentSlot.item;
  }

  void unequip() {
    item = Item.empty();
  }
}
