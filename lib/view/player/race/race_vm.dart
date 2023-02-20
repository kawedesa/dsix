import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/player/race/available_player_races.dart';
import 'package:dsix/model/player/race/player_race.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_widgets/dialog/text_dialog.dart';
import 'package:dsix/view/player/attribute/attribute_view.dart';
import 'package:flutter/material.dart';
import '../../../shared/app_colors.dart';
import '../../../shared/app_images.dart';
import '../../../shared/app_widgets/button/app_circular_button.dart';

class RaceVM {
  final database = FirebaseFirestore.instance;
  PlayerRace selectedRace = AvailablePlayerRaces().getAvailableRaces().first;

  int raceIndex = 0;
  List<PlayerRace> availablePlayerRaces =
      AvailablePlayerRaces().getAvailableRaces();

  void changeRace(int index) {
    raceIndex += index;

    if (raceIndex < 0) {
      raceIndex = availablePlayerRaces.length - 1;
    }
    if (raceIndex > availablePlayerRaces.length - 1) {
      raceIndex = 0;
    }

    selectedRace = availablePlayerRaces[raceIndex];
  }

  void setRace(context, User user) async {
    user.player.setRace(selectedRace.name);
    user.player.update();
    goToAttributeView(context);
  }

  void goToAttributeView(context) {
    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const AttributeView(),
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

  Widget raceBonusIcons(context, User user) {
    Widget bonusIcons = const SizedBox();

    switch (selectedRace.name) {
      case 'orc':
        bonusIcons = Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppCircularButton(
                color: user.color,
                borderColor: user.color,
                iconColor: user.darkColor,
                icon: AppImages.attack,
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TextDialog(
                        title: selectedRace.raceBonus[0].name,
                        dialogText: selectedRace.raceBonus[0].description,
                        color: user.color,
                      );
                    },
                  );
                },
                size: 0.09),
            AppCircularButton(
                color: user.color,
                borderColor: user.color,
                iconColor: user.darkColor,
                icon: AppImages.weight,
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TextDialog(
                        title: selectedRace.raceBonus[1].name,
                        dialogText: selectedRace.raceBonus[1].description,
                        color: user.color,
                      );
                    },
                  );
                },
                size: 0.09),
            AppCircularButton(
                color: AppColors.negative,
                borderColor: AppColors.negative,
                iconColor: Colors.black,
                icon: AppImages.move,
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TextDialog(
                        title: selectedRace.raceBonus[2].name,
                        dialogText: selectedRace.raceBonus[2].description,
                        color: AppColors.negative,
                      );
                    },
                  );
                },
                size: 0.09),
          ],
        );

        break;
      case 'elf':
        bonusIcons = Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppCircularButton(
                color: user.color,
                borderColor: user.color,
                iconColor: user.darkColor,
                icon: AppImages.move,
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TextDialog(
                        title: selectedRace.raceBonus[0].name,
                        dialogText: selectedRace.raceBonus[0].description,
                        color: user.color,
                      );
                    },
                  );
                },
                size: 0.09),
            AppCircularButton(
                color: user.color,
                borderColor: user.color,
                iconColor: user.darkColor,
                icon: AppImages.look,
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TextDialog(
                        title: selectedRace.raceBonus[1].name,
                        dialogText: selectedRace.raceBonus[1].description,
                        color: user.color,
                      );
                    },
                  );
                },
                size: 0.09),
            AppCircularButton(
                color: AppColors.negative,
                borderColor: AppColors.negative,
                iconColor: Colors.black,
                icon: AppImages.health,
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TextDialog(
                        title: selectedRace.raceBonus[2].name,
                        dialogText: selectedRace.raceBonus[2].description,
                        color: AppColors.negative,
                      );
                    },
                  );
                },
                size: 0.09),
          ],
        );
        break;
      case 'dwarf':
        bonusIcons = Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppCircularButton(
                color: user.color,
                borderColor: user.color,
                iconColor: user.darkColor,
                icon: AppImages.defend,
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TextDialog(
                        title: selectedRace.raceBonus[0].name,
                        dialogText: selectedRace.raceBonus[0].description,
                        color: user.color,
                      );
                    },
                  );
                },
                size: 0.09),
            AppCircularButton(
                color: user.color,
                borderColor: user.color,
                iconColor: user.darkColor,
                icon: AppImages.health,
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TextDialog(
                        title: selectedRace.raceBonus[1].name,
                        dialogText: selectedRace.raceBonus[1].description,
                        color: user.color,
                      );
                    },
                  );
                },
                size: 0.09),
            AppCircularButton(
                color: AppColors.negative,
                borderColor: AppColors.negative,
                iconColor: Colors.black,
                icon: AppImages.look,
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TextDialog(
                        title: selectedRace.raceBonus[2].name,
                        dialogText: selectedRace.raceBonus[2].description,
                        color: AppColors.negative,
                      );
                    },
                  );
                },
                size: 0.09),
          ],
        );
        break;
    }

    return bonusIcons;
  }

  void goBackToPlayerSelection(context, Game game, String color) {
    game.deletePlayer(color);
    Navigator.pop(context);
  }
}
