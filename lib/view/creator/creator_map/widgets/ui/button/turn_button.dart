import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TurnButton extends StatelessWidget {
  final Function() fullRefresh;
  const TurnButton({super.key, required this.fullRefresh});

  void passTurn(Game game, List<Npc> npcs, List<Player> players) {
    BattleLog battleLog = BattleLog.empty();

    if (game.turn.currentTurn == 'player') {
      for (Player player in players) {
        int checkLife = player.life.current;
        player.passTurn();
        int damage = checkLife - player.life.current;
        if (damage > 0) {
          battleLog.addTarget(player.id, 'player', player.position, damage);
        }
      }
    } else {
      for (Npc npc in npcs) {
        int checkLife = npc.life.current;
        npc.passTurn();
        int damage = checkLife - npc.life.current;
        if (damage > 0) {
          battleLog.addTarget(npc.id.toString(), 'npc', npc.position, damage);
        }
      }
    }

    game.passTurn();
    battleLog.newBattleLog();
  }

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
      size: 0.04,
      onTap: () {
        passTurn(game, npcs, players);
        fullRefresh();
      },
    );
  }
}
