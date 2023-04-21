import 'package:dsix/model/item/item.dart';

class EquipmentSlot {
  String name;
  Item item;
  EquipmentSlot({required this.name, required this.item});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'item': item.toMap(),
    };
  }

  factory EquipmentSlot.fromMap(Map<String, dynamic>? data) {
    return EquipmentSlot(
      name: data?['name'],
      item: Item.fromMap(data?['item']),
    );
  }

  factory EquipmentSlot.fromItem(String slotName, Item item) {
    return EquipmentSlot(
      name: slotName,
      item: item,
    );
  }

  factory EquipmentSlot.empty(String slotName) {
    return EquipmentSlot(
      name: slotName,
      item: Item.empty(),
    );
  }

  bool isEmpty() {
    if (item.name == 'empty') {
      return true;
    }
    return false;
  }

  bool isEquipped() {
    if (item.name != 'empty') {
      return true;
    }
    return false;
  }

  void equip(Item item) {
    this.item = item;
  }

  void unequip() {
    item = Item.empty();
  }
}
