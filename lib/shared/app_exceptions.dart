class NotEnoughMoneyException implements Exception {
  String message = 'not enough money';

  NotEnoughMoneyException();
}

class TooHeavyException implements Exception {
  String message = 'too heavy';

  TooHeavyException();
}

class ItemBoughtException implements Exception {
  String itemValue;

  ItemBoughtException(this.itemValue);
}

class ItemSoldException implements Exception {
  String itemValue;

  ItemSoldException(this.itemValue);
}

class PlayerNotReadyException implements Exception {
  String playerName;

  PlayerNotReadyException(this.playerName);
}

class EndGameException implements Exception {
  EndGameException();
}
