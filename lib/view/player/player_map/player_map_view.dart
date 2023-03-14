import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/map/action_area_sprite.dart';
import 'package:dsix/shared/app_widgets/map/map_animation/map_animation.dart';
import 'package:dsix/shared/app_widgets/map/map_info.dart';
import 'package:dsix/view/player/player_map/player_map_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../model/npc/npc.dart';
import '../../../shared/app_layout.dart';

class PlayerMapView extends StatefulWidget {
  final Function() refresh;
  const PlayerMapView({Key? key, required this.refresh}) : super(key: key);

  @override
  State<PlayerMapView> createState() => _PlayerMapViewState();
}

class _PlayerMapViewState extends State<PlayerMapView> {
  final PlayerMapVM _playerMapVM = PlayerMapVM();
  final MapInfo _mapInfo = MapInfo.empty();
  final MapAnimation _mapAnimation = MapAnimation();
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final game = Provider.of<Game>(context);
    final npcs = Provider.of<List<Npc>>(context);
    final players = Provider.of<List<Player>>(context);
    final buildings = Provider.of<List<Building>>(context);
    final battleLog = Provider.of<List<BattleLog>>(context);

    user.updatePlayer(players);
    _mapInfo.setMapInfo(context, game.map);
    _mapAnimation.checkBattleLog(battleLog);
    _mapAnimation.checkPlayerTurn(game.turn);

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          InteractiveViewer(
            transformationController: _mapInfo.canvasController,
            constrained: false,
            panEnabled: true,
            maxScale: _mapInfo.minZoom,
            minScale: _mapInfo.minZoom,
            child: SizedBox(
              width: 320,
              height: 320,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    AppImages().getMapImage(game.map),
                    width: AppLayout.longest(context),
                    height: AppLayout.longest(context),
                  ),
                  _playerMapVM.createBuildingSprites(buildings),
                  ActionAreaSprite(
                    area: _playerMapVM.combat.actionArea.area,
                  ),
                  _playerMapVM.createNpcSprites(
                      context, _mapInfo, npcs, players, widget.refresh),
                  _playerMapVM.createPlayerSprites(
                      _mapInfo, players, user.player, refresh),
                  _mapAnimation.displayAttackAnimations(),
                  _mapAnimation.displayDamageAnimations(),
                ],
              ),
            ),
          ),
          _mapAnimation.displayTurnAnimations(),
          _playerMapVM.getAttackInput(npcs, players, user.player, refresh),
          _playerMapVM.actionButtons(_mapInfo, user, refresh),
        ],
      ),
    );
  }
}
