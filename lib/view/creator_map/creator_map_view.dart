import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/view/creator_map/creator_map_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../model/npc/npc.dart';
import '../../model/user.dart';
import '../../shared/app_images.dart';
import '../../shared/app_layout.dart';
import '../../shared/app_widgets/dialog/npc_dialog.dart';

class CreatorMap extends StatefulWidget {
  const CreatorMap({Key? key}) : super(key: key);

  @override
  State<CreatorMap> createState() => _CreatorMapState();
}

class _CreatorMapState extends State<CreatorMap> {
  final CreatorMapVM _creatorMapVM = CreatorMapVM();

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    final spawners = Provider.of<List<Spawner>>(context);
    final npcs = Provider.of<List<Npc>>(context);
    final user = Provider.of<User>(context);

    return Center(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: Stack(
            children: [
              InteractiveViewer(
                transformationController:
                    _creatorMapVM.createCanvasController(context),
                constrained: false,
                panEnabled: true,
                maxScale: _creatorMapVM.maxZoom,
                minScale: _creatorMapVM.minZoom,
                child: SizedBox(
                  width: 320,
                  height: 320,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        game.map.map,
                        width: AppLayout.longest(context),
                        height: AppLayout.longest(context),
                      ),
                      Stack(
                        children: _creatorMapVM.createSpawnerSprites(
                            context, spawners),
                      ),
                      Stack(
                        children: _creatorMapVM.createNpcSprites(context, npcs),
                      )
                      // Stack(
                      //   children: chestController.visibleLoot,
                      // ),
                      // Stack(
                      //   children: enemyController.enemyPlayers,
                      // ),
                      // Consumer<PlayerTempLocation>(
                      //     builder: (context, playerTempLocation, ___) {
                      //   return PlayerSprite(
                      //     refresh: () => refresh(),
                      //     player: user.getPlayer(players),
                      //     tempLocation: playerTempLocation,
                      //   );
                      // }),
                      // FogSprite(),
                      // PlayerMenu(
                      //   refresh: () => refresh(),
                      //   player: user.getPlayer(players),
                      // ),
                    ],
                  ),
                ),
              ),

              Align(
                alignment: const Alignment(-0.95, -0.9),
                child: Column(
                  children: [
                    const AppSeparatorVertical(value: 0.025),
                    AppCircularButton(
                        onTap: () {
                          setState(() {
                            _creatorMapVM.createSpawner(spawners.length);
                          });
                        },
                        icon: AppImages.map,
                        iconColor: user.lightColor.withAlpha(200),
                        color: user.color.withAlpha(100),
                        borderColor: user.lightColor.withAlpha(200),
                        size: 0.1),
                    const AppSeparatorVertical(value: 0.025),
                    AppCircularButton(
                        onTap: () {
                          setState(
                            () {
                              // _creatorMapVM.createNpc(npcs.length);
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return NpcDialog(
                                      color: user.color,
                                      darkColor: user.darkColor,
                                      chooseNpc: (npc) {
                                        int npcId = 0;

                                        if (npcs.isEmpty) {
                                          npcId = 0;
                                        } else {
                                          npcId = npcs.last.id + 1;
                                        }

                                        _creatorMapVM.createNpc(npcId, npc);
                                      },
                                    );
                                  });
                            },
                          );
                        },
                        icon: AppImages.sword,
                        iconColor: user.lightColor.withAlpha(200),
                        color: user.color.withAlpha(100),
                        borderColor: user.lightColor.withAlpha(200),
                        size: 0.1),
                  ],
                ),
              ),

              //       Align(
              //         alignment: Alignment.center,
              //         child: Stack(
              //           children: _mapPageVM.temporaryUI,
              //         ),
              //       ),

              //       //Animation
              //       Align(
              //         alignment: Alignment.center,
              //         child: (_mapPageAnimation.artboard != null)
              //             ? TransparentPointer(
              //                 transparent: true,
              //                 child: SizedBox(
              //                   width: MediaQuery.of(context).size.width,
              //                   height:
              //                       MediaQuery.of(context).size.height * 0.86,
              //                   child: Rive(
              //                     artboard: _mapPageAnimation.artboard!,
              //                     fit: BoxFit.fill,
              //                   ),
              //                 ),
              //               )
              //             : SizedBox(),
              //       ),
              //     ],
              //   ),
              // ),
              // Divider(
              //   thickness: 2,
              //   height: 2,
              //   color: _uiColor.setUIColor(user.id, 'primary'),
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.04,
              //   child: Padding(
              //     padding: const EdgeInsets.all(5.0),
              //     child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       shrinkWrap: true,
              //       padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              //       itemCount: game.round!.turnOrder!.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         return Padding(
              //           padding: const EdgeInsets.only(left: 5),
              //           child: TurnButton(
              //             onDoubleTap: () {
              //               user.selectPlayer(game.round!.turnOrder![index]);
              //               _mapPageVM.goToPlayer(context, game.map!.size!,
              //                   user.getPlayer(players));
              //               refresh();
              //             },
              //             color: _uiColor.setUIColor(
              //                 game.round!.turnOrder![index], 'primary'),
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),
              // Divider(
              //   thickness: 2,
              //   height: 2,
              //   color: _uiColor.setUIColor(user.id, 'primary'),
              // ),
            ],
          ),
        ),
      ]),
    );
  }
}
