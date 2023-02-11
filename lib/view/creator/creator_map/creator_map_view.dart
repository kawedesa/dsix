import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/view/creator/creator_map/creator_map_vm.dart';
import 'package:dsix/view/creator/creator_map/widgets/game_creation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../model/npc/npc.dart';
import '../../../shared/app_layout.dart';

class CreatorMap extends StatefulWidget {
  final Function() refresh;
  final Function(String, Color) displaySnackbar;
  const CreatorMap(
      {Key? key, required this.refresh, required this.displaySnackbar})
      : super(key: key);

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
    final players = Provider.of<List<Player>>(context);

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
                        children: _creatorMapVM.createSpawnerSprites(spawners),
                      ),
                      Stack(
                        children: _creatorMapVM.createNpcSprites(npcs),
                      ),
                      Stack(
                        children: _creatorMapVM.createPlayerSprites(players),
                      ),
                    ],
                  ),
                ),
              ),
              (game.phase == 'creation')
                  ? GameCreationMenu(
                      displaySnackbar: (text, color) {
                        widget.displaySnackbar(text, color);
                      },
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ]),
    );
  }
}
