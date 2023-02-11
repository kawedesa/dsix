import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/view/player/player_map/player_map_vm.dart';
import 'package:dsix/view/player/player_map/widgets/game_pad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../model/npc/npc.dart';
import '../../../shared/app_layout.dart';
import '../../../shared/app_widgets/sprite/area_effect_sprite.dart';

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
  final PlayerMapVM _creatorMapVM = PlayerMapVM();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final game = Provider.of<Game>(context);
    final npcs = Provider.of<List<Npc>>(context);
    final players = Provider.of<List<Player>>(context);

    user.updateUser(players);

    return Center(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: Stack(
            children: [
              InteractiveViewer(
                transformationController: _creatorMapVM.createCanvasController(
                    context, user.player.position),
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
                        children: _creatorMapVM.createNpcSprites(npcs),
                      ),
                      Stack(
                        children: _creatorMapVM.createPlayerSprites(players),
                      ),
                      CustomPaint(
                        painter: AreaEffectSpritePainter(area: user.aoe.area),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                  alignment: const Alignment(0.6, 0.4),
                  child: GamePad(
                    refresh: () {
                      setState(() {});
                    },
                  )),
              // const Align(alignment: Alignment(-0.6, 0.4), child: GamePad()),
            ],
          ),
        ),
      ]),
    );
  }
}
