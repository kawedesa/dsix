import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/map/map_info.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_exceptions.dart';
import 'package:dsix/shared/app_globals.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/shared_widgets/app_snackbar.dart';
import 'package:dsix/shared/shared_widgets/button/app_circular_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartGameButton extends StatelessWidget {
  final bool active;
  const StartGameButton({super.key, required this.active});
  void startGame(Game game, MapInfo mapInfo, List<Player> players,
      List<Spawner> spawners) {
    if (players.length != game.numberOfPlayers) {
      throw PlayersAreNotReadyException();
    }

    for (Player player in players) {
      if (player.ready == false) {
        throw PlayersAreNotReadyException();
      }
    }

    for (Player player in players) {
      player.spawn(mapInfo, spawners.first.position, spawners.first.size);
      player.update();
    }

    game.startGame();
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    final user = Provider.of<User>(context);
    final players = Provider.of<List<Player>>(context);
    final spawners = Provider.of<List<Spawner>>(context);
    return (active)
        ? AppCircularButton(
            onTap: () {
              try {
                startGame(game, user.mapInfo, players, spawners);
              } on PlayersAreNotReadyException catch (e) {
                snackbarKey.currentState?.showSnackBar(AppSnackBar()
                    .getSnackBar(e.message.toUpperCase(), AppColors.uiColor));
              }
            },
            icon: AppImages.confirm,
            iconColor: AppColors.uiColorLight.withAlpha(200),
            color: AppColors.uiColor.withAlpha(100),
            borderColor: AppColors.uiColorLight.withAlpha(200),
            size: 0.03)
        : AppCircularButton(
            icon: AppImages.confirm,
            iconColor: AppColors.uiColor.withAlpha(200),
            color: AppColors.uiColorDark.withAlpha(100),
            borderColor: AppColors.uiColorDark.withAlpha(200),
            size: 0.03);
  }
}
