class Turn {
  int count;
  String currentTurn;
  Turn({
    required this.count,
    required this.currentTurn,
  });

  factory Turn.empty() {
    return Turn(
      count: 1,
      currentTurn: 'player',
    );
  }

  factory Turn.fromMap(Map<String, dynamic>? data) {
    return Turn(
      count: data?['count'],
      currentTurn: data?['currentTurn'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'currentTurn': currentTurn,
    };
  }

  void reset() {
    count = 1;
    currentTurn = 'player';
  }

  void passTurn() {
    count++;
    if (currentTurn == 'player') {
      currentTurn = 'npc';
    } else {
      currentTurn = 'player';
    }
  }
}
