import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_exceptions.dart';
import 'package:dsix/shared/app_globals.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/app_snackbar.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/app_widgets/map/mouse_input.dart';
import 'package:dsix/shared/app_widgets/map/place_here.dart';
import 'package:dsix/view/creator/creator_map/widgets/ui/building_creation_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'npc_creation_button.dart';

class GameCreationMenu extends StatefulWidget {
  final Function() refresh;

  const GameCreationMenu({
    super.key,
    required this.refresh,
  });

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

    game.startGame();
  }

  void createSpawner(int id) {
    Spawner newSpawner = Spawner.newSpawner(id, 50.0, 'players');
    newSpawner.set();
  }

  void localRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    final players = Provider.of<List<Player>>(context);
    final spawners = Provider.of<List<Spawner>>(context);
    final user = Provider.of<User>(context);

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          PlaceHere(
              position:
                  user.mapInfo.getOnScreenPosition(user.placeHere).getOffset()),
          MouseInput(
              active: (user.placingSomething == 'false') ? false : true,
              getMouseOffset: (mouseOffset) {
                user.setPlaceHere(mouseOffset);
                localRefresh();
              },
              onTap: () {
                if (user.placingSomething == 'building') {
                  user.createBuilding();
                  user.resetPlacing();
                  user.deselect();
                }

                if (user.placingSomething == 'npc') {
                  user.createNpc();
                  user.resetPlacing();
                  user.deselect();
                }
              }),
          (user.placingSomething == 'true')
              ? const SizedBox()
              : Align(
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
                              borderColor:
                                  AppColors.uiColorLight.withAlpha(200),
                              size: 0.04)
                          : AppCircularButton(
                              icon: AppImages.spawner,
                              iconColor: AppColors.uiColor.withAlpha(200),
                              color: AppColors.uiColorDark.withAlpha(100),
                              borderColor: AppColors.uiColorDark.withAlpha(200),
                              size: 0.04),
                      const AppSeparatorHorizontal(value: 0.025),
                      NpcCreationButton(
                        active: (spawners.isEmpty) ? false : true,
                        refresh: () {
                          widget.refresh();
                        },
                      ),
                      const AppSeparatorHorizontal(value: 0.025),
                      BuildingCreationButton(
                          active: (spawners.isEmpty) ? false : true,
                          refresh: () {
                            widget.refresh();
                          }),
                      const AppSeparatorHorizontal(value: 0.025),
                      (spawners.isEmpty)
                          ? AppCircularButton(
                              icon: AppImages.confirm,
                              iconColor: AppColors.uiColor.withAlpha(200),
                              color: AppColors.uiColorDark.withAlpha(100),
                              borderColor: AppColors.uiColorDark.withAlpha(200),
                              size: 0.04)
                          : AppCircularButton(
                              onTap: () {
                                setState(() {
                                  try {
                                    startGame(game, players, spawners);
                                  } on PlayerNotReadyException catch (e) {
                                    snackbarKey.currentState?.showSnackBar(
                                        AppSnackBar().getSnackBar(
                                            e.playerName.toUpperCase(),
                                            AppColors.uiColor));
                                  }
                                });
                              },
                              icon: AppImages.confirm,
                              iconColor: AppColors.uiColorLight.withAlpha(200),
                              color: AppColors.uiColor.withAlpha(100),
                              borderColor:
                                  AppColors.uiColorLight.withAlpha(200),
                              size: 0.04)
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
