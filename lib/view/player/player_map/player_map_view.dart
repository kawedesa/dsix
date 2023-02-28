import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_widgets/app_radial_menu.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
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
                        children:
                            _playerMapVM.createNpcSprites(npcs, user.player),
                      ),
                      Stack(
                        children: _playerMapVM.createPlayerSprites(
                            players, user.player, refresh),
                      ),
                      // _playerMapVM.popUpMenu(),
                    ],
                  ),
                ),
              ),
              _playerMapVM.getMouseInput(npcs, players, user.player, refresh),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: AppLayout.shortest(context) * 0.75,
                  height: AppLayout.shortest(context) * 0.3,
                  child: AppRadialMenu(
                    maxAngle: 60,
                    buttonInfo: [
                      ActionButton(
                        active: (_playerMapVM.playerMode == 'attack')
                            ? true
                            : false,
                        color: user.color,
                        darkColor: user.darkColor,
                        resetAction: () {
                          setState(() {
                            _playerMapVM.combat.resetActionArea();
                          });
                        },
                        startAction: (position) {
                          setState(() {
                            _playerMapVM.startAttack(
                              position,
                              user.player.position,
                              user.player.equipment.mainHandSlot.item.attack,
                            );
                          });
                        },
                        cancelAction: () {
                          setState(() {
                            _playerMapVM.cancelAction();
                          });
                        },
                      ),
                      AppCircularButton(
                          color: user.darkColor,
                          borderColor: user.darkColor,
                          size: 0.05),
                      AppCircularButton(
                          color: user.darkColor,
                          borderColor: user.darkColor,
                          size: 0.05),
                      ActionButton(
                        active: (_playerMapVM.playerMode == 'attack')
                            ? true
                            : false,
                        color: user.color,
                        darkColor: user.darkColor,
                        resetAction: () {
                          setState(() {
                            _playerMapVM.combat.resetActionArea();
                          });
                        },
                        startAction: (position) {
                          setState(() {
                            _playerMapVM.startAttack(
                              position,
                              user.player.position,
                              user.player.equipment.offHandSlot.item.attack,
                            );
                          });
                        },
                        cancelAction: () {
                          setState(() {
                            _playerMapVM.cancelAction();
                          });
                        },
                      ),
                    ],
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

class ActionButton extends StatefulWidget {
  final Color color;
  final Color darkColor;
  final bool active;
  final Function(Position) startAction;
  final Function() cancelAction;
  final Function() resetAction;

  const ActionButton({
    super.key,
    required this.color,
    required this.darkColor,
    required this.active,
    required this.startAction,
    required this.cancelAction,
    required this.resetAction,
  });

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  Position buttonPosition = Position.empty();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (details) {
        buttonPosition =
            Position(dx: details.position.dx, dy: details.position.dy);
        if (widget.active) {
          widget.resetAction();
        }
      },
      child: AppCircularButton(
        color: widget.color,
        borderColor: widget.darkColor,
        size: 0.05,
        onTap: () {
          setState(() {
            if (widget.active) {
              widget.cancelAction();
            } else {
              widget.startAction(buttonPosition);
            }
          });
        },
      ),
    );
  }
}
