import 'package:dsix/model/game/game.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/button/app_text_button.dart';
import 'package:dsix/shared/app_widgets/text/app_title.dart';
import 'package:dsix/view/creator_map/creator_map_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../shared/app_layout.dart';
import '../../shared/app_widgets/button/app_circular_button.dart';
import '../../shared/app_widgets/layout/app_separator_vertical.dart';

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

    return Center(
      child: (game.map.name != '')
          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                            // MapTile(),
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
            ])
          : SizedBox(
              width: AppLayout.shortest(context) * 0.9,
              height: AppLayout.height(context) * 0.85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppTitle(
                    title: 'MAP',
                    color: AppColors.uiColor,
                  ),
                  const AppSeparatorVertical(value: 0.025),
                  SizedBox(
                    height: AppLayout.shortest(context) * 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppCircularButton(
                            color: Colors.transparent,
                            borderColor: AppColors.uiColor,
                            iconColor: AppColors.uiColor,
                            icon: AppImages.left,
                            onTap: () {
                              setState(() {
                                // _raceVM.changeRace(-1);
                              });
                            },
                            size: 0.125),
                        SvgPicture.asset(
                          width: AppLayout.shortest(context) * 0.5,
                          height: AppLayout.shortest(context) * 0.5,
                          AppImages.oldRuins,
                        ),
                        AppCircularButton(
                            color: Colors.transparent,
                            borderColor: AppColors.uiColor,
                            iconColor: AppColors.uiColor,
                            icon: AppImages.right,
                            onTap: () {
                              setState(() {
                                // _raceVM.changeRace(1);
                              });
                            },
                            size: 0.125),
                      ],
                    ),
                  ),
                  const AppSeparatorVertical(value: 0.025),
                  AppTextButton(
                      buttonText: 'choose',
                      color: AppColors.uiColor,
                      onTap: () {
                        setState(() {
                          _creatorMapVM.chooseMap(game);
                        });
                      }),
                ],
              ),
            ),
    );
  }
}
