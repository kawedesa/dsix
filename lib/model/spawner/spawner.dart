import 'dart:ui';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class Spawner {
  int id;
  String type;
  double size;
  Offset position;

  Spawner({
    required this.id,
    required this.type,
    required this.size,
    required this.position,
  });

  final database = FirebaseFirestore.instance;

  factory Spawner.newSpawner(int id, double spawnerSize) {
    double dx = Random().nextDouble() * 320;
    double dy = Random().nextDouble() * 320;

    return Spawner(
      id: id,
      type: '',
      size: spawnerSize,
      position: Offset(dx, dy),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'size': size,
      'positionDx': position.dx,
      'positionDy': position.dy,
    };
  }

  factory Spawner.fromMap(Map<String, dynamic>? data) {
    return Spawner(
      id: data?['id'],
      type: data?['type'],
      size: data?['size'] * 1.0,
      position: Offset(data?['positionDx'] * 1.0, data?['positionDy'] * 1.0),
    );
  }

  void changePosition(Offset newPosition) {
    position = newPosition;
    update();
  }

  void update() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('spawners')
        .doc(id.toString())
        .set(toMap());
  }

  void set() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('spawners')
        .doc(id.toString())
        .set(toMap());
  }
}
