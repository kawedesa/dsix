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
