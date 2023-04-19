import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/model/game/game.dart';

import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/shared_widgets/button/app_circular_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TurnButton extends StatelessWidget {
  final Function() fullRefresh;
  const TurnButton({super.key, required this.fullRefresh});

  @override
  Widget build(BuildContext context) {
    final npcs = Provider.of<List<Npc>>(context);
    final players = Provider.of<List<Player>>(context);
    final game = Provider.of<Game>(context);

    return AppCircularButton(
      icon: AppImages.turn,
      iconColor: (game.turn.currentTurn == 'player')
          ? AppColors.uiColor.withAlpha(200)
          : AppColors.uiColorLight.withAlpha(200),
      color: (game.turn.currentTurn == 'player')
          ? AppColors.uiColorDark.withAlpha(100)
          : AppColors.uiColor.withAlpha(100),
      borderColor: (game.turn.currentTurn == 'player')
          ? AppColors.uiColorDark.withAlpha(200)
          : AppColors.uiColorLight.withAlpha(200),
      size: 0.03,
      onTap: () {
        game.passTurn(players, npcs);
        fullRefresh();
      },
    );
  }
}
