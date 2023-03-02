import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/view/player/player_map/player_map_vm.dart';
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

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
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
                    children: _playerMapVM.createNpcSprites(npcs, user.player),
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
          _playerMapVM.getAttackInput(npcs, players, user.player, refresh),
          Align(
              alignment: const Alignment(0, 0.25),
              child: SizedBox(
                  width: AppLayout.shortest(context) * 0.75,
                  height: AppLayout.shortest(context) * 0.3,
                  child: _playerMapVM.actionButtons(user, refresh))),
          _playerMapVM.endGameButton(context, game.phase, user.player),
        ],
      ),
    );
  }
}
