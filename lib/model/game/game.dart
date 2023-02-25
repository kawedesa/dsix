import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/map/app_map.dart';

class Game {
  String phase;

  int difficulty;
  int round;
  AppMap map;
  String quest;
  int numberOfPlayers;
  List<String> availablePlayers;
  List<String> choosenPlayers;

  Game({
    required this.phase,
    required this.difficulty,
    required this.round,
    required this.map,
    required this.quest,
    required this.numberOfPlayers,
    required this.availablePlayers,
    required this.choosenPlayers,
  });
  final database = FirebaseFirestore.instance;

  Map<String, dynamic> toMap() {
    return {
      'phase': phase,
      'difficulty': difficulty,
      'round': round,
      'map': map.toMap(),
      'quest': quest,
      'numberOfPlayers': numberOfPlayers,
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
      difficulty: data?['difficulty'],
      round: data?['round'],
      map: AppMap.fromMap(data?['map']),
      quest: data?['quest'],
      numberOfPlayers: data?['numberOfPlayers'],
      availablePlayers: availablePlayers,
      choosenPlayers: choosenPlayers,
    );
  }

  factory Game.empty() {
    return Game(
      phase: 'empty',
      difficulty: 0,
      round: 0,
      map: AppMap.empty(),
      quest: '',
      numberOfPlayers: 0,
      availablePlayers: ['blue', 'pink', 'green', 'yellow', 'purple'],
      choosenPlayers: [],
    );
  }

  factory Game.newGame(int choosenDifficulty, int numberOfPlayers) {
    return Game(
      phase: 'creation',
      difficulty: choosenDifficulty,
      round: 1,
      map: AppMap.empty(),
      quest: '',
      numberOfPlayers: numberOfPlayers,
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

  void newGame(int choosenDifficulty, int numberOfPlayers) async {
    await database
        .collection('game')
        .doc('gameID')
        .set(Game.newGame(choosenDifficulty, numberOfPlayers).toMap());
  }

  void startGame() {
    phase = 'action';
    update();
  }

  void endGame() {
    phase = 'end';
    update();
  }

  void deleteGame() async {
    await database.collection('game').doc('gameID').set(Game.empty().toMap());
    deleteAllPlayers();
    deleteSpawners();
    deleteNpcs();
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

  void update() async {
    await database.collection('game').doc('gameID').update(toMap());
  }
}
