class Player {
  String id;
  String name;
  String race;
  int attributes;
  int maxHealth;
  int currentHealth;
  int maxWeight;
  int currentWeight;
  int attack;
  int defend;
  int move;
  int look;
  Player(
      {required this.id,
      required this.name,
      required this.race,
      required this.attributes,
      required this.maxHealth,
      required this.currentHealth,
      required this.maxWeight,
      required this.currentWeight,
      required this.attack,
      required this.defend,
      required this.move,
      required this.look});

  factory Player.newPlayer(String id) {
    return Player(
        id: id,
        name: '',
        race: '',
        attributes: 0,
        maxHealth: 0,
        currentHealth: 0,
        maxWeight: 0,
        currentWeight: 0,
        attack: 0,
        defend: 0,
        move: 0,
        look: 0);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'race': race,
      'attributes': attributes,
      'maxHealth': maxHealth,
      'currentHealth': currentHealth,
      'maxWeight': maxWeight,
      'currentWeight': currentWeight,
      'attack': attack,
      'defend': defend,
      'move': move,
      'look': look,
    };
  }

  factory Player.fromMap(Map<String, dynamic>? data) {
    return Player(
      id: data?['id'],
      name: data?['name'],
      race: data?['race'],
      attributes: data?['attributes'],
      maxHealth: data?['maxHealth'],
      currentHealth: data?['currentHealth'],
      maxWeight: data?['maxWeight'],
      currentWeight: data?['currentWeight'],
      attack: data?['attack'],
      defend: data?['defend'],
      move: data?['move'],
      look: data?['look'],
    );
  }

  void setRace(String race) {
    this.race = race;
    switch (race) {
      case 'orc':
        attributes = 2;
        maxHealth = 12;
        currentHealth = 12;
        maxWeight = 14;
        currentWeight = 0;
        attack = 1;
        defend = 0;
        move = -1;
        look = 0;
        break;
      case 'elf':
        attributes = 2;
        maxHealth = 10;
        currentHealth = 10;
        maxWeight = 12;
        currentWeight = 0;
        attack = 0;
        defend = 0;
        move = 1;
        look = 1;
        break;
      case 'dwarf':
        attributes = 2;
        maxHealth = 14;
        currentHealth = 14;
        maxWeight = 12;
        currentWeight = 0;
        attack = 0;
        defend = 1;
        move = 0;
        look = -1;
        break;
    }
  }
}
