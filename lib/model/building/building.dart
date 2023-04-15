import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/combat/position.dart';

class Building {
  int id;
  String name;
  double size;
  Position position;

  Building({
    required this.id,
    required this.name,
    required this.size,
    required this.position,
  });

  final database = FirebaseFirestore.instance;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'size': size,
      'position': position.toMap(),
    };
  }

  factory Building.fromMap(Map<String, dynamic>? data) {
    return Building(
      id: data?['id'],
      name: data?['name'],
      size: data?['size'],
      position: Position.fromMap(data?['position']),
    );
  }

  void changePosition(Position newPosition) {
    position = newPosition;
    update();
  }

  void changeSize(double value) {
    size += value;

    if (size < 20) {
      size = 20;
    }
    if (size > 50) {
      size = 50;
    }

    update();
  }

  void delete() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('buildings')
        .doc(id.toString())
        .delete();
  }

  void update() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('buildings')
        .doc(id.toString())
        .set(toMap());
  }

  void set() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('buildings')
        .doc(id.toString())
        .set(toMap());
  }
}
