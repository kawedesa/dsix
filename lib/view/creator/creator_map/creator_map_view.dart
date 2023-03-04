import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'creator_map_vm.dart';
import 'widgets/creator_map_action_mode.dart';
import 'widgets/creator_map_edit_mode.dart';

class CreatorMapView extends StatefulWidget {
  final Function() refresh;
  final Function(String, Color) displaySnackBar;
  const CreatorMapView(
      {super.key, required this.refresh, required this.displaySnackBar});

  @override
  State<CreatorMapView> createState() => _CreatorMapViewState();
}

class _CreatorMapViewState extends State<CreatorMapView> {
  final CreatorMapVM _creatorMapVM = CreatorMapVM();

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    final npcs = Provider.of<List<Npc>>(context);

    _creatorMapVM.mapInfo.setMapInfo(context, game.map);
    _creatorMapVM.updateSelectedNpc(npcs);

    return (game.phase == 'action')
        ? CreatorMapActionMode(
            mapInfo: _creatorMapVM.mapInfo,
            selectedNpc: _creatorMapVM.selectedNpc,
            selectNpc: (npc) {
              setState(() {
                _creatorMapVM.selectNpc(npc);
              });
            },
            deselect: () {
              setState(() {
                _creatorMapVM.deselectNpc();
              });
            },
            createNpc: (position) {
              setState(() {
                _creatorMapVM.createNpc(position);
              });
            },
            displaySnackBar: (text, color) {
              widget.displaySnackBar(text, color);
            },
          )
        : CreatorMapEditMode(
            mapInfo: _creatorMapVM.mapInfo,
            selectedNpc: _creatorMapVM.selectedNpc,
            selectNpc: (npc) {
              setState(() {
                _creatorMapVM.selectNpc(npc);
              });
            },
            deselect: () {
              setState(() {
                _creatorMapVM.deselectNpc();
              });
            },
            createNpc: (position) {
              setState(() {
                _creatorMapVM.createNpc(position);
              });
            },
            displaySnackBar: (text, color) =>
                widget.displaySnackBar(text, color),
          );
  }
}
