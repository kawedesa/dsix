import 'package:dsix/model/combat/attack.dart';
import '../combat/armor.dart';

class Item {
  String name;
  String description;
  String itemSlot;
  String type;
  bool needsReload;
  bool isLoaded;
  List<String> effects;
  List<Attack> attacks;
  Armor armor;
  int weight;
  int value;

  Item({
    required this.name,
    required this.description,
    required this.itemSlot,
    required this.type,
    required this.needsReload,
    required this.isLoaded,
    required this.effects,
    required this.attacks,
    required this.armor,
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
      type: data?['type'],
      needsReload: data?['needsReload'],
      isLoaded: data?['isLoaded'],
      effects: getEffects,
      attacks: getAttacks,
      armor: Armor.fromMap(data?['armor']),
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
      'type': type,
      'needsReload': needsReload,
      'isLoaded': isLoaded,
      'effects': effects,
      'attacks': attacksToMap,
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
      needsReload: false,
      isLoaded: false,
      effects: [],
      attacks: [],
      armor: Armor.empty(),
      weight: 0,
      value: 0,
    );
  }
}
