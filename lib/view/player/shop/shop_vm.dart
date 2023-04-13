import 'package:dsix/model/item/item.dart';
import 'package:dsix/model/item/shop.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_exceptions.dart';
import 'package:dsix/shared/app_globals.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/app_snackbar.dart';
import 'package:dsix/view/player/shop/shop_dialog.dart';
import 'package:dsix/shared/app_widgets/text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../model/player/player.dart';

class ShopVM {
  final Shop _shop = Shop();
  int selectedMenu = 0;
  String menuTitle = 'light weapons';
  List<Item> fullItemList = [];
  List<Item> itemList = [];
  int selectedItemIndex = 0;

  void changeMenu(int menuIndex) {
    selectedItemIndex = 0;
    switch (menuIndex) {
      case 0:
        selectedMenu = 0;
        menuTitle = 'light weapons';
        break;
      case 1:
        selectedMenu = 1;
        menuTitle = 'heavy weapons';
        break;
      case 2:
        selectedMenu = 2;
        menuTitle = 'ranged weapons';
        break;
      case 3:
        selectedMenu = 3;
        menuTitle = 'magic weapons';
        break;
      case 4:
        selectedMenu = 4;
        menuTitle = 'armor';
        break;
      case 5:
        selectedMenu = 5;
        menuTitle = 'consumables';
        break;
    }
  }

  void setShopMenu() {
    fullItemList = [];
    switch (menuTitle) {
      case 'light weapons':
        for (Item item in _shop.lightWeapons) {
          fullItemList.add(item);
        }
        break;
      case 'heavy weapons':
        for (Item item in _shop.heavyWeapons) {
          fullItemList.add(item);
        }
        break;
      case 'ranged weapons':
        for (Item item in _shop.rangedWeapons) {
          fullItemList.add(item);
        }
        break;
      case 'magic weapons':
        for (Item item in _shop.magicWeapons) {
          fullItemList.add(item);
        }
        break;
      case 'armor':
        for (Item item in _shop.armor) {
          fullItemList.add(item);
        }
        break;
      case 'consumables':
        for (Item item in _shop.consumables) {
          fullItemList.add(item);
        }
        break;
    }

    setDisplayItems();
  }

  void setDisplayItems() {
    if (fullItemList.isEmpty) {
      return;
    }
    itemList = [];

    if (fullItemList.length < 4) {
      for (Item item in fullItemList) {
        itemList.add(item);
      }
      return;
    }

    for (int i = 0; i < 3; i++) {
      int itemIndex = selectedItemIndex + i;

      if (itemIndex > fullItemList.length - 1) {
        int wrapAroundItemIndex = itemIndex - fullItemList.length;
        itemList.add(fullItemList[wrapAroundItemIndex]);
      } else {
        itemList.add(fullItemList[itemIndex]);
      }
    }
  }

  void changeSelectedItem(int value) {
    if (fullItemList.isEmpty) {
      return;
    }

    selectedItemIndex += value;
    if (selectedItemIndex >= fullItemList.length - 1) {
      selectedItemIndex = 0;
    }

    if (selectedItemIndex < 0) {
      selectedItemIndex = fullItemList.length - 1;
    }
    setDisplayItems();
  }

  Widget getItems(context, User user, Function refresh) {
    List<Widget> menu = [];

    menu.add(GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ShopDialog(
              item: itemList[0],
              color: user.color,
              darkColor: user.darkColor,
              buyItem: () {
                try {
                  Navigator.pop(context);
                  buyItem(itemList[0], user.player);
                } on NotEnoughMoneyException catch (e) {
                  snackbarKey.currentState?.showSnackBar(AppSnackBar()
                      .getSnackBar(e.message.toUpperCase(), user.color));
                } on TooHeavyException catch (e) {
                  snackbarKey.currentState?.showSnackBar(AppSnackBar()
                      .getSnackBar(e.message.toUpperCase(), user.color));
                } on ItemBoughtException catch (e) {
                  snackbarKey.currentState?.showSnackBar(AppSnackBar()
                      .getSnackBar(e.itemValue.toUpperCase(), user.color));
                }
                refresh();
              },
            );
          },
        );
      },
      child: SizedBox(
        width: AppLayout.avarage(context) * 0.125,
        height: AppLayout.avarage(context) * 0.125,
        child: Stack(
          children: [
            SvgPicture.asset(
              AppImages().getItemIcon(itemList[0].name),
              color: Colors.white,
              width: AppLayout.avarage(context) * 0.125,
              height: AppLayout.avarage(context) * 0.125,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AppText(
                text: itemList[0].value.toString(),
                color: user.color,
                fontSize: 0.02,
                letterSpacing: 0.004,
              ),
            ),
          ],
        ),
      ),
    ));

    menu.add(GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ShopDialog(
              item: itemList[1],
              color: user.color,
              darkColor: user.darkColor,
              buyItem: () {
                try {
                  Navigator.pop(context);
                  buyItem(itemList[1], user.player);
                } on NotEnoughMoneyException catch (e) {
                  snackbarKey.currentState?.showSnackBar(AppSnackBar()
                      .getSnackBar(e.message.toUpperCase(), user.color));
                } on TooHeavyException catch (e) {
                  snackbarKey.currentState?.showSnackBar(AppSnackBar()
                      .getSnackBar(e.message.toUpperCase(), user.color));
                } on ItemBoughtException catch (e) {
                  snackbarKey.currentState?.showSnackBar(AppSnackBar()
                      .getSnackBar(e.itemValue.toUpperCase(), user.color));
                }
                refresh();
              },
            );
          },
        );
      },
      child: SizedBox(
        width: AppLayout.avarage(context) * 0.3,
        height: AppLayout.avarage(context) * 0.3,
        child: Stack(
          children: [
            SvgPicture.asset(
              AppImages().getItemIcon(itemList[1].name),
              width: AppLayout.avarage(context) * 0.3,
              height: AppLayout.avarage(context) * 0.3,
              color: Colors.white,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AppText(
                text: itemList[1].value.toString(),
                color: user.color,
                fontSize: 0.05,
                letterSpacing: 0.004,
              ),
            ),
          ],
        ),
      ),
    ));

    menu.add(GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ShopDialog(
              item: itemList[2],
              color: user.color,
              darkColor: user.darkColor,
              buyItem: () {
                try {
                  Navigator.pop(context);
                  buyItem(itemList[2], user.player);
                } on NotEnoughMoneyException catch (e) {
                  snackbarKey.currentState?.showSnackBar(AppSnackBar()
                      .getSnackBar(e.message.toUpperCase(), user.color));
                } on TooHeavyException catch (e) {
                  snackbarKey.currentState?.showSnackBar(AppSnackBar()
                      .getSnackBar(e.message.toUpperCase(), user.color));
                } on ItemBoughtException catch (e) {
                  snackbarKey.currentState?.showSnackBar(AppSnackBar()
                      .getSnackBar(e.itemValue.toUpperCase(), user.color));
                }
                refresh();
              },
            );
          },
        );
      },
      child: SizedBox(
        width: AppLayout.avarage(context) * 0.125,
        height: AppLayout.avarage(context) * 0.125,
        child: Stack(
          children: [
            SvgPicture.asset(
              AppImages().getItemIcon(itemList[2].name),
              color: Colors.white,
              width: AppLayout.avarage(context) * 0.125,
              height: AppLayout.avarage(context) * 0.125,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AppText(
                text: itemList[2].value.toString(),
                color: user.color,
                fontSize: 0.02,
                letterSpacing: 0.004,
              ),
            ),
          ],
        ),
      ),
    ));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: menu,
    );
  }

  void buyItem(Item item, Player player) {
    if (player.equipment.notEnoughMoney(item.value)) {
      throw NotEnoughMoneyException();
    }
    if (player.equipment.tooHeavy(item.weight)) {
      throw TooHeavyException();
    }
    player.buyItem(item);

    throw ItemBoughtException('- \$${item.value}');
  }
}
