import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'creator_map_vm.dart';

class CreatorMapView extends StatelessWidget {
  CreatorMapView({super.key});

  final CreatorMapVM _creatorMapVM = CreatorMapVM();

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    final user = Provider.of<User>(context);

    user.mapInfo.setMap(game.map);

    return _creatorMapVM.getMapView(game.phase);
  }
}
