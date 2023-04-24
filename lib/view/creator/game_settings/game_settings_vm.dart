import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/view/home/home_view.dart';
import 'package:flutter/material.dart';

class GameSettingsVM {
  void newRound(Game game, User user, List<Player> players) {
    game.newRound();
    user.deselect();
    for (Player player in players) {
      player.newRound();
    }
  }

  void goToHomeView(context) {
    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const HomeView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(-1.0, 0.0);
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
