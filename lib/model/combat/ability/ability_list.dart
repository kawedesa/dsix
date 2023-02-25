import '../range.dart';
import 'ability.dart';

class AbilityList {
  static Ability bite = Ability(
    name: 'bite',
    range: Range(min: 5, max: 15, width: 10, type: 'rectangle'),
  );

  static Ability punch = Ability(
    name: 'punch',
    range: Range(min: 5, max: 15, width: 10, type: 'rectangle'),
  );

  static Ability slash = Ability(
    name: 'slash',
    range: Range(
      min: 5,
      max: 20,
      width: 20,
      type: 'cone',
    ),
  );

  static Ability shot = Ability(
      name: 'shot',
      range: Range(min: 20, max: 70, width: 10, type: 'rectangle'));
}
