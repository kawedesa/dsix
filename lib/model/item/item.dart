import 'package:dsix/model/combat/attack.dart';
import '../combat/armor.dart';

class Item {
  String name;
  String description;
  String itemSlot;
  List<String> effects;
  List<Attack> attacks;
  Armor armor;
  int numberOfUses;
  int weight;
  int value;

  Item({
    required this.name,
    required this.description,
    required this.itemSlot,
    required this.effects,
    required this.attacks,
    required this.armor,
    required this.numberOfUses,
    required this.weight,
    required this.value,
  });

  factory Item.fromMap(Map<String, dynamic>? data) {
    List<String> getEffects = [];
    List<dynamic> effectsMap = data?['effects'];
    for (var effect in effectsMap) {
      getEffects.add(effect);
    }

    List<Attack> getAttacks = [];
    List<dynamic> attacksMap = data?['attacks'];
    for (var attack in attacksMap) {
      getAttacks.add(Attack.fromMap(attack));
    }

    return Item(
      name: data?['name'],
      description: data?['description'],
      itemSlot: data?['itemSlot'],
      effects: getEffects,
      attacks: getAttacks,
      armor: Armor.fromMap(data?['armor']),
      numberOfUses: data?['numberOfUses'],
      weight: data?['weight'],
      value: data?['value'],
    );
  }

  Map<String, dynamic> toMap() {
    var attacksToMap = attacks.map((attack) => attack.toMap()).toList();

    return {
      'name': name,
      'description': description,
      'itemSlot': itemSlot,
      'effects': effects,
      'attacks': attacksToMap,
      'armor': armor.toMap(),
      'numberOfUses': numberOfUses,
      'weight': weight,
      'value': value,
    };
  }

  factory Item.empty() {
    return Item(
      name: 'empty',
      description: '',
      itemSlot: '',
      effects: [],
      attacks: [],
      armor: Armor.empty(),
      numberOfUses: 0,
      weight: 0,
      value: 0,
    );
  }
}
