import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/view/player/player_map/player_map_vm.dart';
import 'package:dsix/shared/app_widgets/map/game_pad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../model/npc/npc.dart';
import '../../../shared/app_layout.dart';
import '../../../shared/app_widgets/map/sprite/area_effect_sprite.dart';

class PlayerMapView extends StatefulWidget {
  final Function() refresh;
  final Function(String, Color) displaySnackbar;
  const PlayerMapView(
      {Key? key, required this.refresh, required this.displaySnackbar})
      : super(key: key);

  @override
  State<PlayerMapView> createState() => _PlayerMapViewState();
}

class _PlayerMapViewState extends State<PlayerMapView> {
  final PlayerMapVM _playerMapVM = PlayerMapVM();

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final game = Provider.of<Game>(context);
    final npcs = Provider.of<List<Npc>>(context);
    final players = Provider.of<List<Player>>(context);

    return Center(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: Stack(
            children: [
              InteractiveViewer(
                transformationController: _playerMapVM.createCanvasController(
                    context, user.player.position),
                constrained: false,
                panEnabled: true,
                maxScale: _playerMapVM.maxZoom,
                minScale: _playerMapVM.minZoom,
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
                      AreaEffectSprite(
                        area: _playerMapVM.combat.areaEffect.area,
                      ),
                      Stack(
                        children: _playerMapVM.createNpcSprites(npcs),
                      ),
                      Stack(
                        children: _playerMapVM.createPlayerSprites(
                            players, user.player, refresh),
                      ),
                      _playerMapVM.popUpMenu(),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.6, 0.4),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeOutCubic,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: (_playerMapVM.playerMode == 'wait' ||
                          game.phase == 'end')
                      ? const SizedBox()
                      : GamePad(
                          color: user.color,
                          cancelColor: AppColors.cancel,
                          onPanStart: () {
                            _playerMapVM.playerMode = 'attack';
                            refresh();
                          },
                          onPanUpdate: (angle, distance) {
                            _playerMapVM.combat.setAttack(
                                angle,
                                distance,
                                user.player.position,
                                user.player.equipment.offHandSlot.item.attack);

                            refresh();
                          },
                          onPanEnd: () {
                            _playerMapVM.playerMode = 'stand';

                            _playerMapVM.combat.confirmPlayerAttack(
                                npcs,
                                players,
                                user.player,
                                user.player.equipment.offHandSlot.item.attack);
                            _playerMapVM.combat.resetAttack();
                            refresh();
                          },
                          cancel: () {
                            _playerMapVM.combat.resetAttack();
                            refresh();
                          },
                        ),
                ),
              ),
              Align(
                alignment: const Alignment(-0.6, 0.4),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeOutCubic,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: (_playerMapVM.playerMode == 'wait' ||
                          game.phase == 'end')
                      ? const SizedBox()
                      : GamePad(
                          color: user.color,
                          cancelColor: AppColors.cancel,
                          onPanStart: () {
                            _playerMapVM.playerMode = 'attack';
                            refresh();
                          },
                          onPanUpdate: (angle, distance) {
                            _playerMapVM.combat.setAttack(
                                angle,
                                distance,
                                user.player.position,
                                user.player.equipment.mainHandSlot.item.attack);

                            refresh();
                          },
                          onPanEnd: () {
                            _playerMapVM.playerMode = 'stand';

                            _playerMapVM.combat.confirmPlayerAttack(
                                npcs,
                                players,
                                user.player,
                                user.player.equipment.mainHandSlot.item.attack);
                            _playerMapVM.combat.resetAttack();
                            refresh();
                          },
                          cancel: () {
                            _playerMapVM.combat.resetAttack();
                            refresh();
                          },
                        ),
                ),
              ),
              _playerMapVM.endGameButton(context, game.phase, user.player),
            ],
          ),
        ),
      ]),
    );
  }
}
