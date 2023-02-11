import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/combat/position.dart';
import '../../../model/npc/npc.dart';
import '../../../model/spawner/spawner.dart';
import '../../../shared/app_exceptions.dart';
import '../../../shared/app_images.dart';
import '../../../shared/app_widgets/button/app_circular_button.dart';
import 'npc_creation_dialog.dart';
import '../../../shared/app_widgets/layout/app_separator_horizontal.dart';
import '../../../shared/app_widgets/layout/app_separator_vertical.dart';

class GameCreationMenu extends StatefulWidget {
  final Function(String, Color) displaySnackbar;
  const GameCreationMenu({super.key, required this.displaySnackbar});

  @override
  State<GameCreationMenu> createState() => _GameCreationMenuState();
}

class _GameCreationMenuState extends State<GameCreationMenu> {
  void startGame(Game game, List<Player> players, List<Spawner> spawners) {
    if (spawners.isEmpty) {
      return;
    }
    if (players.length != game.numberOfPlayers) {
      return;
    }

    for (Player player in players) {
      if (player.ready == false) {
        throw PlayerNotReadyException(player.id);
      }
    }

    for (Player player in players) {
      player.spawn(spawners.first.position, spawners.first.size);
    }
  }

  void createSpawner(int id) {
    Spawner newSpawner = Spawner.newSpawner(id, 50.0, 'players');
    newSpawner.set();
  }

  void createNpc(Npc selectedNpc, List<Npc> npcs) {
    int newNpcId = 0;

    if (npcs.isEmpty) {
      newNpcId = 0;
    } else {
      newNpcId = npcs.last.id + 1;
    }

    Npc newNpc = selectedNpc;
    newNpc.id = newNpcId;
    newNpc.position = Position(dx: 160, dy: 160);
    newNpc.set();
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    final players = Provider.of<List<Player>>(context);
    final spawners = Provider.of<List<Spawner>>(context);
    final npcs = Provider.of<List<Npc>>(context);

    return (game.phase == 'creation')
        ? Align(
            alignment: const Alignment(0, 0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppSeparatorVertical(value: 0.025),
                (spawners.isEmpty)
                    ? AppCircularButton(
                        onTap: () {
                          setState(() {
                            createSpawner(spawners.length);
                          });
                        },
                        icon: AppImages.spawner,
                        iconColor: AppColors.uiColorLight.withAlpha(200),
                        color: AppColors.uiColor.withAlpha(100),
                        borderColor: AppColors.uiColorLight.withAlpha(200),
                        size: 0.1)
                    : AppCircularButton(
                        icon: AppImages.spawner,
                        iconColor: AppColors.uiColor.withAlpha(200),
                        color: AppColors.uiColorDark.withAlpha(100),
                        borderColor: AppColors.uiColorDark.withAlpha(200),
                        size: 0.1),
                const AppSeparatorHorizontal(value: 0.025),
                (spawners.isEmpty)
                    ? AppCircularButton(
                        icon: AppImages.sword,
                        iconColor: AppColors.uiColor.withAlpha(200),
                        color: AppColors.uiColorDark.withAlpha(100),
                        borderColor: AppColors.uiColorDark.withAlpha(200),
                        size: 0.1)
                    : AppCircularButton(
                        onTap: () {
                          setState(
                            () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return NpcCreationDialog(
                                      chooseNpc: (npc) {
                                        createNpc(npc, npcs);
                                      },
                                    );
                                  });
                            },
                          );
                        },
                        icon: AppImages.sword,
                        iconColor: AppColors.uiColorLight.withAlpha(200),
                        color: AppColors.uiColor.withAlpha(100),
                        borderColor: AppColors.uiColorLight.withAlpha(200),
                        size: 0.1),
                const AppSeparatorHorizontal(value: 0.025),
                (spawners.isEmpty)
                    ? AppCircularButton(
                        icon: AppImages.confirm,
                        iconColor: AppColors.uiColor.withAlpha(200),
                        color: AppColors.uiColorDark.withAlpha(100),
                        borderColor: AppColors.uiColorDark.withAlpha(200),
                        size: 0.1)
                    : AppCircularButton(
                        onTap: () {
                          setState(() {
                            try {
                              startGame(game, players, spawners);
                            } on PlayerNotReadyException catch (e) {
                              widget.displaySnackbar(e.playerName.toUpperCase(),
                                  AppColors.uiColor);
                            }
                          });
                        },
                        icon: AppImages.confirm,
                        iconColor: AppColors.uiColorLight.withAlpha(200),
                        color: AppColors.uiColor.withAlpha(100),
                        borderColor: AppColors.uiColorLight.withAlpha(200),
                        size: 0.1)
              ],
            ),
          )
        : const SizedBox();
  }
}
