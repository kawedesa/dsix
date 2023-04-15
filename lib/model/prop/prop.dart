import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/combat/position.dart';

class Prop {
  int id;
  String name;
  double size;
  Position position;

  Prop({
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

  factory Prop.fromMap(Map<String, dynamic>? data) {
    return Prop(
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
