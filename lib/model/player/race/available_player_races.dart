import 'package:dsix/model/player/race/player_race.dart';

class AvailablePlayerRaces {
  static final PlayerRace orc = PlayerRace('orc', [
    PlayerRaceBonus('warrior', 'You are a warrior and know how to fight.'),
    PlayerRaceBonus('strong', 'You are strong and can carry more things.'),
    PlayerRaceBonus('big', 'Your size makes you slower than others.')
  ]);

  static final PlayerRace elf = PlayerRace('elf', [
    PlayerRaceBonus('fast', 'You are fast and can cover more ground.'),
    PlayerRaceBonus(
        'perceptive', 'You have perfect vision and amazing hearing.'),
    PlayerRaceBonus('frail', 'You have less health than others.')
  ]);

  static final PlayerRace dwarf = PlayerRace('dwarf', [
    PlayerRaceBonus('sturdy',
        'You can hold your ground and protect yourself better than others.'),
    PlayerRaceBonus('tough', 'You can take more blows befores going down.'),
    PlayerRaceBonus('stubborn',
        'Your size and stubborn personality limits your perception of things.')
  ]);

  List<PlayerRace> getAvailableRaces() {
    return [
      orc,
      elf,
      dwarf,
    ];
  }
}
