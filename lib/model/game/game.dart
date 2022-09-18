class Game {
  String phase;
  List<String> availablePlayers;

  Game({
    required this.phase,
    required this.availablePlayers,
  });

  Map<String, dynamic> toMap() {
    return {
      'phase': phase,
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
      availablePlayers: availablePlayers,
    );
  }

  factory Game.newGame() {
    return Game(
      phase: 'creation',
      availablePlayers: ['blue', 'pink', 'green', 'yellow', 'purple'],
    );
  }
}
