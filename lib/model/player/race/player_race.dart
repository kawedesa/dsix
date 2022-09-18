class PlayerRace {
  String name;
  List<PlayerRaceBonus> raceBonus;
  PlayerRace(this.name, this.raceBonus);
}

class PlayerRaceBonus {
  String name;
  String description;
  PlayerRaceBonus(this.name, this.description);
}
