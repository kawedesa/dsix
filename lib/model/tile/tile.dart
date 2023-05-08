import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/combat/position.dart';

class Tile {
  int id;
  String name;
  double size;
  double rotation;
  Position position;
  bool verticalFlip;
  bool horizontalFlip;
  bool visibility;

  Tile({
    required this.id,
    required this.name,
    required this.size,
    required this.rotation,
    required this.position,
    required this.verticalFlip,
    required this.horizontalFlip,
    required this.visibility,
  });

  final database = FirebaseFirestore.instance;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'size': size,
      'rotation': rotation,
      'position': position.toMap(),
      'verticalFlip': verticalFlip,
      'horizontalFlip': horizontalFlip,
      'visibility': visibility,
    };
  }

  factory Tile.fromMap(Map<String, dynamic>? data) {
    return Tile(
      id: data?['id'],
      name: data?['name'],
      size: data?['size'],
      rotation: data?['rotation'],
      position: Position.fromMap(data?['position']),
      verticalFlip: data?['verticalFlip'],
      horizontalFlip: data?['horizontalFlip'],
      visibility: data?['visibility'],
    );
  }

  void setId() {
    id = DateTime.now().millisecondsSinceEpoch;
  }

  void flipVertical() {
    if (verticalFlip) {
      verticalFlip = false;
    } else {
      verticalFlip = true;
    }
    update();
  }

  void flipHorizontal() {
    if (horizontalFlip) {
      horizontalFlip = false;
    } else {
      horizontalFlip = true;
    }
    update();
  }

  void changePosition(Position newPosition) {
    position = newPosition;
    update();
  }

  void resetPosition() {
    position = Position.empty();
  }

  void changeRotation(double value) {
    rotation += value;
    update();
  }

  void changeSize(double value) {
    size += value;

    if (size < 64) {
      size = 64;
    }
    if (size > 128) {
      size = 128;
    }

    update();
  }

  void changeVisibility() {
    if (visibility) {
      visibility = false;
    } else {
      visibility = true;
    }
    update();
  }

  void delete() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('tiles')
        .doc(id.toString())
        .delete();
  }

  void update() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('tiles')
        .doc(id.toString())
        .set(toMap());
  }

  void set() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('tiles')
        .doc(id.toString())
        .set(toMap());
  }
}
