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

class TakeDamageException implements Exception {
  int damage;

  TakeDamageException(this.damage);
}

class PlayersAreNotReadyException implements Exception {
  String message = 'players are not ready';

  PlayersAreNotReadyException();
}

class EndGameException implements Exception {
  EndGameException();
}
