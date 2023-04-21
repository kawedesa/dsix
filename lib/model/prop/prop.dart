import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/item/item.dart';
import 'package:dsix/model/item/shop.dart';

class Prop {
  int id;
  String name;
  double size;
  Position position;
  List<Item> loot;

  Prop({
    required this.id,
    required this.name,
    required this.size,
    required this.position,
    required this.loot,
  });

  final database = FirebaseFirestore.instance;

  Map<String, dynamic> toMap() {
    var loot = this.loot.map((item) => item.toMap()).toList();
    return {
      'id': id,
      'name': name,
      'size': size,
      'position': position.toMap(),
      'loot': loot,
    };
  }

  factory Prop.fromMap(Map<String, dynamic>? data) {
    List<Item> loot = [];
    List<dynamic> lootMap = data?['loot'];

    for (var item in lootMap) {
      loot.add(Item.fromMap(item));
    }

    return Prop(
      id: data?['id'],
      name: data?['name'],
      size: data?['size'],
      position: Position.fromMap(data?['position']),
      loot: loot,
    );
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

  void addItemToLoot(Item item) {
    loot.add(item);
    update();
  }

  void removeItemFromLoot(Item item) {
    loot.remove(item);
    update();
  }

  void createLoot(int lootValue) {
    loot = Shop().createRandomLoot(lootValue);
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
        .collection('props')
        .doc(id.toString())
        .delete();
  }

  void update() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('props')
        .doc(id.toString())
        .set(toMap());
  }

  void set() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('props')
        .doc(id.toString())
        .set(toMap());
  }
}
