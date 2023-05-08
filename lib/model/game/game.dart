import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/game/turn.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';

class Game {
  String phase;

  int round;
  Turn turn;
  String map;
  String quest;
  int numberOfPlayers;
  int startingGold;
  bool sharedTeamVision;
  List<String> availablePlayers;
  List<String> choosenPlayers;

  Game({
    required this.phase,
    required this.round,
    required this.turn,
    required this.map,
    required this.quest,
    required this.numberOfPlayers,
    required this.startingGold,
    required this.sharedTeamVision,
    required this.availablePlayers,
    required this.choosenPlayers,
  });
  final database = FirebaseFirestore.instance;

  Map<String, dynamic> toMap() {
    return {
      'phase': phase,
      'round': round,
      'turn': turn.toMap(),
      'map': map,
      'quest': quest,
      'numberOfPlayers': numberOfPlayers,
      'startingGold': startingGold,
      'sharedTeamVision': sharedTeamVision,
      'availablePlayers': availablePlayers,
      'choosenPlayers': choosenPlayers,
    };
  }

  factory Game.fromMap(Map<String, dynamic>? data) {
    List<String> availablePlayers = [];
    List<dynamic> availablePlayersMap = data?['availablePlayers'];
    for (var playerID in availablePlayersMap) {
      availablePlayers.add(playerID);
    }

    List<String> choosenPlayers = [];
    List<dynamic> choosenPlayersMap = data?['choosenPlayers'];
    for (var playerID in choosenPlayersMap) {
      choosenPlayers.add(playerID);
    }

    return Game(
      phase: data?['phase'],
      round: data?['round'],
      turn: Turn.fromMap(data?['turn']),
      map: data?['map'],
      quest: data?['quest'],
      numberOfPlayers: data?['numberOfPlayers'],
      startingGold: data?['startingGold'],
      sharedTeamVision: data?['sharedTeamVision'],
      availablePlayers: availablePlayers,
      choosenPlayers: choosenPlayers,
    );
  }

  factory Game.empty() {
    return Game(
      phase: 'empty',
      round: 0,
      turn: Turn.empty(),
      map: '',
      quest: '',
      numberOfPlayers: 0,
      startingGold: 0,
      sharedTeamVision: true,
      availablePlayers: ['blue', 'pink', 'green', 'yellow', 'purple'],
      choosenPlayers: [],
    );
  }

  factory Game.newGame(
      int numberOfPlayers, int startingGold, bool sharedTeamVision) {
    return Game(
      phase: 'creation',
      round: 1,
      turn: Turn.empty(),
      map: '',
      quest: '',
      numberOfPlayers: numberOfPlayers,
      startingGold: startingGold,
      sharedTeamVision: sharedTeamVision,
      availablePlayers: ['blue', 'pink', 'green', 'yellow', 'purple'],
      choosenPlayers: [],
    );
  }

  void choosePlayer(String color) async {
    choosenPlayers.add(color);
    update();
  }

  void deletePlayer(String color) async {
    choosenPlayers.remove(color);

    update();

    await database
        .collection('game')
        .doc('gameID')
        .collection('players')
        .doc(color)
        .delete();
  }

  void newGame(
      int numberOfPlayers, int startingGold, bool sharedTeamVision) async {
    await database.collection('game').doc('gameID').set(
        Game.newGame(numberOfPlayers, startingGold, sharedTeamVision).toMap());
  }

  void newRound() {
    deleteSpawners();
    deleteTiles();
    deleteBuildings();
    deleteNpcs();
    deleteProps();
    deleteBattleLog();
    round++;
    turn.reset();
    phase = 'creation';
    map = '';
    update();
  }

  void passTurn(List<Player> players, List<Npc> npcs) {
    turn.passTurn(players, npcs);
    update();
  }

  void startGame() {
    phase = 'action';
    update();
  }

  void endGame() {
    phase = 'end';
    update();
  }

  void chooseMap(String map) {
    this.map = map;
    update();
  }

  void deleteGame() async {
    await database.collection('game').doc('gameID').set(Game.empty().toMap());
    deleteAllPlayers();
    deleteSpawners();
    deleteTiles();
    deleteBuildings();
    deleteNpcs();
    deleteProps();
    deleteBattleLog();
  }

  void deleteAllPlayers() async {
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

  void deleteTiles() async {
    var tileBatch = database.batch();

    await database
        .collection('game')
        .doc('gameID')
        .collection('tiles')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        tileBatch.delete(ds.reference);
      }
    });

    tileBatch.commit();
  }

  void deleteSpawners() async {
    var spawnerBatch = database.batch();

    await database
        .collection('game')
        .doc('gameID')
        .collection('spawners')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        spawnerBatch.delete(ds.reference);
      }
    });

    spawnerBatch.commit();
  }

  void deleteBuildings() async {
    var buildingBatch = database.batch();

    await database
        .collection('game')
        .doc('gameID')
        .collection('buildings')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        buildingBatch.delete(ds.reference);
      }
    });

    buildingBatch.commit();
  }

  void deleteNpcs() async {
    var npcBatch = database.batch();

    await database
        .collection('game')
        .doc('gameID')
        .collection('npcs')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        npcBatch.delete(ds.reference);
      }
    });

    npcBatch.commit();
  }

  void deleteProps() async {
    var propBatch = database.batch();

    await database
        .collection('game')
        .doc('gameID')
        .collection('props')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        propBatch.delete(ds.reference);
      }
    });

    propBatch.commit();
  }

  void deleteBattleLog() async {
    var battleLogBatch = database.batch();

    await database
        .collection('game')
        .doc('gameID')
        .collection('battleLog')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        battleLogBatch.delete(ds.reference);
      }
    });

    battleLogBatch.commit();
  }

  void update() async {
    await database.collection('game').doc('gameID').update(toMap());
  }
}
