import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/game/game.dart';

class GameSettingsVM {
  final database = FirebaseFirestore.instance;

  void newGame() async {
    await database.collection('game').doc('gameID').set(Game.newGame().toMap());
    deletePlayers();
  }

  void deletePlayers() async {
    var playerBatch = database.batch();

    await database
        .collection('game')
        .doc('gameID')
        .collection('players')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        playerBatch.delete(ds.reference);
      }
    });

    playerBatch.commit();
  }
}
