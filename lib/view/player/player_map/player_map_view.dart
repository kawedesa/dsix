import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/map/menu/map_menu.dart';
import 'package:dsix/model/map/sprites/action_area_sprite.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/chest/chest.dart';
import 'package:dsix/model/tile/tile.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/images/app_images.dart';

import 'package:dsix/model/map/map_animations/map_animation.dart';
import 'package:dsix/view/player/player_map/player_map_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../model/npc/npc.dart';
import '../../../shared/app_layout.dart';
import '../../../model/map/buttons/player/player_action_buttons.dart';

class PlayerMapView extends StatefulWidget {
  final Function() refresh;
  const PlayerMapView({Key? key, required this.refresh}) : super(key: key);

  @override
  State<PlayerMapView> createState() => _PlayerMapViewState();
}

class _PlayerMapViewState extends State<PlayerMapView> {
  final PlayerMapVM _playerMapVM = PlayerMapVM();
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
    final tiles = Provider.of<List<Tile>>(context);
    final chests = Provider.of<List<Chest>>(context);
    final battleLog = Provider.of<List<BattleLog>>(context);

    _mapAnimation.checkBattleLog(battleLog);
    _mapAnimation.checkPlayerTurn(game.turn);
    user.mapInfo.setMap(game.map);
    user.setPlayerMode(game.turn.currentTurn);

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          InteractiveViewer(
            transformationController: user.mapInfo.canvasController,
            constrained: false,
            panEnabled: true,
            maxScale: user.mapInfo.zoom,
            minScale: user.mapInfo.zoom,
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
                  _playerMapVM.createTileSprites(tiles),
                  _playerMapVM.createBuildingSprites(
                      user, buildings, players, game.sharedTeamVision),
                  ActionAreaSprite(
                    area: user.combat.actionArea.area,
                  ),
                  _mapAnimation.displayAttackAnimations(),
                  _playerMapVM.createChestSprites(
                      user, chests, players, game.sharedTeamVision),
                  _playerMapVM.createDeadNpcSprites(
                      user, npcs, players, game.sharedTeamVision),
                  _playerMapVM.createDeadPlayerSprites(players),
                  _playerMapVM.createNpcSprites(
                      user, npcs, players, game.sharedTeamVision),
                  _playerMapVM.createPlayerSprites(user, players),
                  _mapAnimation.displayDamageAnimations(),
                  _mapAnimation.displayAuraAnimations(),
                  _mapAnimation.displayAuraAnimations(),
                ],
              ),
            ),
          ),
          _mapAnimation.displayTurnAnimations(),
          PlayerActioButtons(fullRefresh: refresh),
          MapMenu(
            color: user.color,
            borderColor: user.lightColor,
            refresh: () => refresh(),
          ),
        ],
      ),
    );
  }
}
