import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'creator_map_vm.dart';

class CreatorMapView extends StatefulWidget {
  final Function() refresh;
  const CreatorMapView({super.key, required this.refresh});

  @override
  State<CreatorMapView> createState() => _CreatorMapViewState();
}

class _CreatorMapViewState extends State<CreatorMapView> {
  final CreatorMapVM _creatorMapVM = CreatorMapVM();

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    final user = Provider.of<User>(context);

    user.mapInfo.setMapInfo(context, game.map);

    return _creatorMapVM.getMapView(game.phase);
  }
}
