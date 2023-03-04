import '../../../model/game/game.dart';

class CreatorMapSelectionVM {
  void chooseMap(Game game) {
    game.map = 'old ruins';
    game.update();
  }

  void chooseQuest(Game game) {
    game.quest = 'kill';
    game.update();
  }
}
