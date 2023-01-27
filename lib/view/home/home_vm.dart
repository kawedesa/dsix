import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/view/creator/creator_view.dart';
import 'package:flutter/material.dart';
import '../race/race_view.dart';

class HomeVM {
  int menuIndex = 0;

  void goToTheStart() {
    menuIndex = 0;
  }

  void chooseRole() {
    menuIndex = 1;
  }

  void playerSelection() {
    menuIndex = 2;
  }

  void choosePlayer(context, Game game, User user, String color) {
    newPlayer(game, user, color);
    game.removeAvailablePlayer(color);
    goToRaceView(context);
  }

  void newPlayer(Game game, User user, String color) {
    Player newPlayer = Player.newPlayer(color);
    user.selectPlayer(newPlayer);
    newPlayer.set();
  }

  void goToControllerHubView(context) {
    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const CreatorView(),
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

  void goToRaceView(context) {
    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const RaceView(),
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
