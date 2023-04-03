import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/model/combat/combat.dart';
import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/view/creator/creator_map/widgets/ui/building_creation_button.dart';
import 'package:dsix/view/creator/creator_map/widgets/ui/npc_creation_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InGameMenu extends StatefulWidget {
  final bool active;

  final Function() refresh;
  const InGameMenu({super.key, required this.active, required this.refresh});

  @override
  State<InGameMenu> createState() => _InGameMenuState();
}

class _InGameMenuState extends State<InGameMenu> {
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

    return (widget.active)
        ? Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(AppLayout.avarage(context) * 0.025,
                  AppLayout.avarage(context) * 0.035, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NpcCreationButton(
                      active: true,
                      refresh: () {
                        widget.refresh();
                      }),
                  const AppSeparatorVertical(value: 0.02),
                  BuildingCreationButton(
                    active: true,
                    refresh: () {
                      widget.refresh();
                    },
                  ),
                  const AppSeparatorVertical(value: 0.02),
                  AppCircularButton(
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
                    },
                  ),
                ],
              ),
            ))
        : const SizedBox();
  }
}
