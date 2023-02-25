import 'package:dsix/model/combat/range.dart';

import '../combat/armor.dart';
import '../combat/damage.dart';

class Item {
  String name;
  String description;
  String itemSlot;
  String type;
  Damage damage;
  Armor armor;
  int weight;
  int value;
  Range range;
  Item({
    required this.name,
    required this.description,
    required this.itemSlot,
    required this.type,
    required this.damage,
    required this.armor,
    required this.weight,
    required this.value,
    required this.range,
  });

  factory Item.fromMap(Map<String, dynamic>? data) {
    return Item(
      name: data?['name'],
      description: data?['description'],
      itemSlot: data?['itemSlot'],
      type: data?['type'],
      damage: Damage.fromMap(data?['damage']),
      armor: Armor.fromMap(data?['armor']),
      weight: data?['weight'],
      value: data?['value'],
      range: Range.fromMap(data?['range']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'itemSlot': itemSlot,
      'type': type,
      'damage': damage.toMap(),
      'armor': armor.toMap(),
      'weight': weight,
      'value': value,
      'range': range.toMap(),
    };
  }

  factory Item.empty() {
    return Item(
      name: 'fist',
      description: '',
      itemSlot: '',
      type: '',
      damage: Damage.empty(),
      armor: Armor.empty(),
      weight: 0,
      value: 0,
      range: Range(min: 5, max: 15, width: 10, type: 'rectangle'),
    );
  }
}
