import 'package:dsix/shared/app_layout.dart';
import 'package:flutter/material.dart';

import '../../../model/combat/position.dart';

class MapInfo {
  double mapSize;
  double minZoom = 8;
  double maxZoom = 16;
  List<Path> grass = [];
  TransformationController? canvasController;

  MapInfo({required this.mapSize, this.canvasController});

  factory MapInfo.empty() {
    return MapInfo(mapSize: 0, canvasController: null);
  }

  void setMapInfo(context, String mapName) {
    minZoom = 2 + AppLayout.longest(context) * 0.0025;

    canvasController ??= TransformationController(Matrix4(
        minZoom, 0, 0, 0, 0, minZoom, 0, 0, 0, 0, minZoom, 0, 0, 0, 0, 1));

    switch (mapName) {
      case 'old ruins':
        mapSize = 320;

        break;
    }
  }

  Position getPlayerOnScreenPosition(Position position) {
    return Position(
        dx: (position.dx * minZoom) +
            (getCanvasPosition().dx * minZoom) -
            1 * minZoom,
        dy: (position.dy * minZoom) +
            (getCanvasPosition().dy * minZoom) +
            7 * minZoom,
        tile: '');
  }

  Position getCanvasPosition() {
    return Position(
        dx: canvasController!.value.row0.w / minZoom,
        dy: canvasController!.value.row1.w / minZoom,
        tile: '');
  }
}

class MapList {
  static MapInfo oldRuins = MapInfo(
    mapSize: 320,
  );
}
