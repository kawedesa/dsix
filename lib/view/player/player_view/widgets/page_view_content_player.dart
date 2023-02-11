import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/game/game.dart';
import '../../inventory/inventory_view.dart';
import '../../player_map/player_map_view.dart';
import '../../shop/shop_view.dart';

class PageViewContentPlayer extends StatelessWidget {
  final PageController controller;
  final Function() refresh;
  final Function(String, Color) displaySnackbar;

  const PageViewContentPlayer(
      {super.key,
      required this.controller,
      required this.refresh,
      required this.displaySnackbar});

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);

    return PageView(
      controller: controller,
      children: (game.phase == 'creation')
          ? [
              InventoryView(
                refresh: () => refresh(),
                displaySnackbar: (text, color) => displaySnackbar(text, color),
              ),
              ShopView(
                refresh: () => refresh(),
                displaySnackbar: (text, color) => displaySnackbar(text, color),
              ),
            ]
          : [
              InventoryView(
                refresh: () => refresh(),
                displaySnackbar: (text, color) => displaySnackbar(text, color),
              ),
              PlayerMapView(
                refresh: () => refresh(),
                displaySnackbar: (text, color) => displaySnackbar(text, color),
              ),
            ],
    );
  }
}
