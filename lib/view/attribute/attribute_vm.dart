import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/player/player.dart';

class AttributeVM {
  final database = FirebaseFirestore.instance;

  void plus(Player player, String attribute) {
    if (player.attributes == 0) {
      return;
    }

    switch (attribute) {
      case 'attack':
        if (player.attack < 2) {
          player.attack++;
          player.attributes--;
        }
        break;
      case 'defend':
        if (player.defend < 2) {
          player.defend++;
          player.attributes--;
        }
        break;
      case 'look':
        if (player.look < 2) {
          player.look++;
          player.attributes--;
        }
        break;
      case 'move':
        if (player.move < 2) {
          player.move++;
          player.attributes--;
        }
        break;
    }

    updatePlayer(player);
  }

  void minus(Player player, String attribute) {
    if (player.attributes == 2) {
      return;
    }

    int baseAttack = 0;
    int baseDefend = 0;
    int baseLook = 0;
    int baseMove = 0;

    switch (player.race) {
      case 'orc':
        baseAttack = 1;
        baseMove = -1;

        break;
      case 'elf':
        baseLook = 1;
        baseMove = 1;
        break;
      case 'dwarf':
        baseLook = -1;
        baseDefend = 1;
        break;
    }

    switch (attribute) {
      case 'attack':
        if (player.attack > baseAttack) {
          player.attack--;
          player.attributes++;
        }
        break;
      case 'defend':
        if (player.defend > baseDefend) {
          player.defend--;
          player.attributes++;
        }
        break;
      case 'look':
        if (player.look > baseLook) {
          player.look--;
          player.attributes++;
        }
        break;
      case 'move':
        if (player.move > baseMove) {
          player.move--;
          player.attributes++;
        }
        break;
    }

    updatePlayer(player);
  }

  void confirm(Player player, String name) {
    player.name = name;
    updatePlayer(player);
  }

  void updatePlayer(Player player) async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('players')
        .doc(player.id)
        .update(player.toMap());
  }
}
