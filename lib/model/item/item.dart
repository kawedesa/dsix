import 'package:dsix/model/combat/attack.dart';
import '../combat/armor.dart';

class Item {
  String name;
  String description;
  String itemSlot;
  String type;
  Attack attack;
  // Damage damage;
  Armor armor;
  int weight;
  int value;
  // Range range;
  Item({
    required this.name,
    required this.description,
    required this.itemSlot,
    required this.type,
    required this.attack,
    required this.armor,
    required this.weight,
    required this.value,
  });

  factory Item.fromMap(Map<String, dynamic>? data) {
    return Item(
      name: data?['name'],
      description: data?['description'],
      itemSlot: data?['itemSlot'],
      type: data?['type'],
      attack: Attack.fromMap(data?['attack']),
      armor: Armor.fromMap(data?['armor']),
      weight: data?['weight'],
      value: data?['value'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'itemSlot': itemSlot,
      'type': type,
      'attack': attack.toMap(),
      'armor': armor.toMap(),
      'weight': weight,
      'value': value,
    };
  }

  factory Item.empty() {
    return Item(
      name: 'empty',
      description: '',
      itemSlot: '',
      type: '',
      attack: Attack.empty(),
      armor: Armor.empty(),
      weight: 0,
      value: 0,
    );
  }
}
