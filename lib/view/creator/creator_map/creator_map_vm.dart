import 'package:flutter/material.dart';

import 'widgets/creator_map_action_mode.dart';
import 'widgets/creator_map_edit_mode.dart';

class CreatorMapVM {
  Widget getMapView(String gamePhase) {
    Widget mapView = const SizedBox();

    switch (gamePhase) {
      case 'empty':
        break;

      case 'creation':
        mapView = const CreatorMapEditMode();

        break;

      case 'action':
        mapView = const CreatorMapActionMode();
        break;
    }
    return mapView;
  }
}
