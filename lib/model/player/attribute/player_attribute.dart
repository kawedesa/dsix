class PlayerAttribute {
  int availablePoints;
  int attack;
  int defend;
  int move;
  int look;
  PlayerAttribute(
      {required this.availablePoints,
      required this.attack,
      required this.defend,
      required this.move,
      required this.look});

  factory PlayerAttribute.empty() {
    return PlayerAttribute(
        availablePoints: 0, attack: 0, defend: 0, move: 0, look: 0);
  }

  factory PlayerAttribute.fromMap(Map<String, dynamic>? data) {
    return PlayerAttribute(
      availablePoints: data?['availablePoints'],
      attack: data?['attack'],
      defend: data?['defend'],
      move: data?['move'],
      look: data?['look'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'availablePoints': availablePoints,
      'attack': attack,
      'defend': defend,
      'move': move,
      'look': look,
    };
  }

  void setAttribute(String race) {
    switch (race) {
      case 'orc':
        availablePoints = 2;
        attack = 1;
        defend = 0;
        move = -1;
        look = 0;
        break;
      case 'elf':
        availablePoints = 2;
        attack = 0;
        defend = 0;
        move = 1;
        look = 1;
        break;
      case 'dwarf':
        availablePoints = 2;
        attack = 0;
        defend = 1;
        move = 0;
        look = -1;
        break;
    }
  }

  void add(String attribute) {
    switch (attribute) {
      case 'attack':
        if (attack < 2) {
          attack++;
          availablePoints--;
        }
        break;
      case 'defend':
        if (defend < 2) {
          defend++;
          availablePoints--;
        }
        break;
      case 'look':
        if (look < 2) {
          look++;
          availablePoints--;
        }
        break;
      case 'move':
        if (move < 2) {
          move++;
          availablePoints--;
        }
        break;
    }
  }

  void remove(String attribute, String race) {
    int baseAttack = 0;
    int baseDefend = 0;
    int baseLook = 0;
    int baseMove = 0;

    switch (race) {
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
        if (attack > baseAttack) {
          attack--;
          availablePoints++;
        }
        break;
      case 'defend':
        if (defend > baseDefend) {
          defend--;
          availablePoints++;
        }
        break;
      case 'look':
        if (look > baseLook) {
          look--;
          availablePoints++;
        }
        break;
      case 'move':
        if (move > baseMove) {
          move--;
          availablePoints++;
        }
        break;
    }
  }
}
