import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/item/item.dart';
import 'package:dsix/model/item/shop.dart';

class Chest {
  int id;
  String name;
  double size;
  Position position;
  List<Item> loot;
  bool locked;

  Chest({
    required this.id,
    required this.name,
    required this.size,
    required this.position,
    required this.loot,
    required this.locked,
  });

  final database = FirebaseFirestore.instance;

  factory Chest.empty() {
    return Chest(
        id: 0,
        name: '',
        size: 10,
        position: Position.empty(),
        loot: [],
        locked: false);
  }

  Map<String, dynamic> toMap() {
    var loot = this.loot.map((item) => item.toMap()).toList();
    return {
      'id': id,
      'name': name,
      'size': size,
      'position': position.toMap(),
      'loot': loot,
      'locked': locked,
    };
  }

  factory Chest.fromMap(Map<String, dynamic>? data) {
    List<Item> loot = [];
    List<dynamic> lootMap = data?['loot'];

    for (var item in lootMap) {
      loot.add(Item.fromMap(item));
    }

    return Chest(
      id: data?['id'],
      name: data?['name'],
      size: data?['size'],
      position: Position.fromMap(data?['position']),
      loot: loot,
      locked: data?['locked'],
    );
  }

  void setId() {
    id = DateTime.now().millisecondsSinceEpoch;
  }

  void changePosition(Position newPosition) {
    position = newPosition;
    update();
  }

  bool lootIsEmpty() {
    if (loot.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void unlock() {
    locked = false;
    update();
  }

  void addItemToLoot(Item item) {
    loot.add(item);
    update();
  }

  void removeItemFromLoot(Item item) {
    loot.remove(item);
    update();
  }

  void createLoot(int lootValue) {
    switch (name) {
      case 'normal chest':
        loot = Shop().createLoot(lootValue, 'normal');
        break;
      case 'magic chest':
        loot = Shop().createLoot(lootValue, 'magic');
        break;
    }
    update();
  }

  int getLootValue() {
    int lootValue = 0;

    if (lootIsEmpty()) {
      return lootValue;
    }

    for (Item item in loot) {
      lootValue += item.value;
    }
    return lootValue;
  }

  void delete() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('chests')
        .doc(id.toString())
        .delete();
  }

  void update() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('chests')
        .doc(id.toString())
        .set(toMap());
  }

  void set() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('chests')
        .doc(id.toString())
        .set(toMap());
  }
}
