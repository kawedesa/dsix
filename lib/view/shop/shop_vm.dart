import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/item/item.dart';
import 'package:dsix/model/item/shop.dart';
import 'package:dsix/shared/app_exceptions.dart';

import '../../model/player/player.dart';

class ShopVM {
  final database = FirebaseFirestore.instance;
  final Shop _shop = Shop();
  int selectedMenu = 0;
  String menuTitle = 'melee';
  List<Item> itemList = [];

  void changeMenu(int menuIndex) {
    switch (menuIndex) {
      case 0:
        selectedMenu = 0;
        menuTitle = 'melee';
        break;
      case 1:
        selectedMenu = 1;
        menuTitle = 'ranged';
        break;
      case 2:
        selectedMenu = 2;
        menuTitle = 'armor';
        break;
      case 3:
        selectedMenu = 3;
        menuTitle = 'consumables';
        break;
    }
  }

  void setItemList() {
    itemList = [];
    switch (menuTitle) {
      case 'melee':
        for (Item item in _shop.meleeWeapons) {
          itemList.add(item);
        }
        break;
      case 'ranged':
        for (Item item in _shop.rangedWeapons) {
          itemList.add(item);
        }
        break;
      case 'armor':
        for (Item item in _shop.armor) {
          itemList.add(item);
        }
        break;
      case 'consumables':
        for (Item item in _shop.consumable) {
          itemList.add(item);
        }
        break;
    }
  }

  void buyItem(Item item, Player player) {
    if (player.equipment.notEnoughMoney(item.value)) {
      throw NotEnoughMoneyException();
    }
    if (player.equipment.tooHeavy(item.weight)) {
      throw TooHeavyException();
    }
    player.equipment.buyItem(item);
    updatePlayer(player);

    throw ItemBoughtException('- \$${item.value}');
  }

  void updatePlayer(Player player) async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('players')
        .doc(player.id)
        .update(player.toMap());
  }
}
