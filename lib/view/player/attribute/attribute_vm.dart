import 'package:dsix/model/player/player.dart';
import 'package:dsix/view/player/player_view/player_view.dart';
import 'package:flutter/material.dart';

class AttributeVM {
  void addAttribute(Player player, String selectedAttribute) {
    if (player.attributes.availablePoints == 0) {
      return;
    }
    player.attributes.add(selectedAttribute);
    player.update();
  }

  void removeAttribute(Player player, String selectedAttribute) {
    if (player.attributes.availablePoints == 2) {
      return;
    }
    player.attributes.remove(selectedAttribute, player.race);
    player.update();
  }

  void chooseName(Player player, String name) {
    player.chooseName(name);
    player.update();
  }

  void goToPlayerView(context) {
    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const PlayerView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
        var end = const Offset(0.0, 0.0);
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );

    Navigator.of(context).push(newRoute);
  }
}
