import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/view/player/player_view.dart';
import 'package:flutter/material.dart';

class AttributeVM {
  final database = FirebaseFirestore.instance;

  void addAttribute(Player player, String selectedAttribute) {
    if (player.attributes == 0) {
      return;
    }
    player.addAttribute(selectedAttribute);
    updatePlayer(player);
  }

  void removeAttribute(Player player, String selectedAttribute) {
    if (player.attributes == 2) {
      return;
    }
    player.removeAttribute(selectedAttribute);
    updatePlayer(player);
  }

  void finishPlayer(Player player, String name) {
    player.finishPlayer(name);
    updatePlayer(player);
  }

  void updatePlayer(Player player) async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('players')
        .doc(player.id)
        .update(player.toMap());
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
