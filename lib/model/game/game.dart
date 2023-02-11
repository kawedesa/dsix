import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/map/app_map.dart';
import 'package:dsix/model/spawner/spawner.dart';
import '../player/player.dart';

class Game {
  String phase;

  int difficulty;
  int round;
  AppMap map;
  String quest;
  int numberOfPlayers;

  List<String> availablePlayers;

  Game({
    required this.phase,
    required this.difficulty,
    required this.round,
    required this.map,
    required this.quest,
    required this.numberOfPlayers,
    required this.availablePlayers,
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
    };
  }

  factory Game.fromMap(Map<String, dynamic>? data) {
    List<String> availablePlayers = [];
    List<dynamic> availablePlayersMap = data?['availablePlayers'];
    for (var playerID in availablePlayersMap) {
      availablePlayers.add(playerID);
    }

    return Game(
      phase: data?['phase'],
      difficulty: data?['difficulty'],
      round: data?['round'],
      map: AppMap.fromMap(data?['map']),
      quest: data?['quest'],
      numberOfPlayers: data?['numberOfPlayers'],
      availablePlayers: availablePlayers,
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
    );
  }

  void removeAvailablePlayer(String color) async {
    availablePlayers.remove(color);
    update();
  }

  void newGame(int choosenDifficulty, int numberOfPlayers) async {
    await database
        .collection('game')
        .doc('gameID')
        .update(Game.newGame(choosenDifficulty, numberOfPlayers).toMap());
  }

  void startGame(List<Player> players, List<Spawner> spawners) {
    phase = 'action';
    update();
  }

  void deleteGame() async {
    await database.collection('game').doc('gameID').set(Game.empty().toMap());
    deletePlayers();
    deleteSpawners();
    deleteNpcs();
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
