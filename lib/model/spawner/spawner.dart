import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/combat/position.dart';

class Spawner {
  int id;
  double size;
  Position position;

  Spawner({
    required this.id,
    required this.size,
    required this.position,
  });

  final database = FirebaseFirestore.instance;

  factory Spawner.newSpawner(
      int spawnerId, double spawnerSize, String spawnerType) {
    return Spawner(
      id: spawnerId,
      size: spawnerSize,
      position: Position(dx: 160, dy: 160, tile: ''),
    );
  }

  factory Spawner.empty() {
    return Spawner(
      id: 0,
      size: 0,
      position: Position.empty(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'size': size, 'position': position.toMap()};
  }

  factory Spawner.fromMap(Map<String, dynamic>? data) {
    return Spawner(
      id: data?['id'],
      size: data?['size'] * 1.0,
      position: Position.fromMap(data?['position']),
    );
  }

  void changePosition(Position newPosition) {
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
