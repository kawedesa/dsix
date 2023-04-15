import 'package:dsix/shared/app_layout.dart';
import 'package:flutter/material.dart';

import '../combat/position.dart';

class MapInfo {
  double mapSize;
  double minZoom = 8;
  double maxZoom = 16;
  Path grass = Path();
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
        grass = Path()
          ..moveTo(96, 120)
          ..lineTo(125, 100)
          ..lineTo(140, 100)
          ..lineTo(160, 120)
          ..lineTo(96, 120)

          //

          ..moveTo(264, 84)
          ..lineTo(264, 72)
          ..lineTo(212, 72)
          ..lineTo(208, 80)
          ..lineTo(212, 84)
          ..lineTo(264, 84)
          //
          ..moveTo(228, 196)
          ..lineTo(232, 192)
          ..lineTo(232, 184)
          ..lineTo(208, 184)
          ..lineTo(208, 196)
          ..lineTo(228, 196)
          //
          ..moveTo(320, 186)
          ..lineTo(296, 196)
          ..lineTo(284, 212)
          ..lineTo(284, 220)
          ..lineTo(272, 232)
          ..lineTo(272, 250)
          ..lineTo(280, 256)
          ..lineTo(268, 268)
          ..lineTo(236, 280)
          ..lineTo(215, 320)
          ..lineTo(320, 320)
          ..lineTo(320, 186)
          //
          ..moveTo(104, 248)
          ..lineTo(108, 240)
          ..lineTo(148, 240)
          ..lineTo(148, 252)
          ..lineTo(108, 252)
          ..lineTo(104, 248)
          //
          ..moveTo(68, 292)
          ..lineTo(108, 292)
          ..lineTo(136, 320)
          ..lineTo(68, 320)
          ..lineTo(68, 292)
          //
          ..moveTo(44, 240)
          ..lineTo(40, 232)
          ..lineTo(24, 216)
          ..lineTo(0, 216)
          ..lineTo(0, 320)
          ..lineTo(44, 320)
          ..lineTo(44, 240)
          ..moveTo(32, 136)
          ..lineTo(56, 136)
          ..lineTo(40, 120)
          ..lineTo(48, 112)
          ..lineTo(40, 104)
          ..lineTo(36, 96)
          ..lineTo(0, 96)
          ..lineTo(0, 168)
          ..lineTo(24, 168)
          ..lineTo(44, 148)
          ..lineTo(32, 136);
        break;
    }
  }

  Position getOnScreenPosition(Position position) {
    return Position(
        dx: (position.dx * minZoom) + (getCanvasPosition().dx * minZoom),
        dy: (position.dy * minZoom) + (getCanvasPosition().dy * minZoom),
        tile: '');
  }

  Position getCanvasPosition() {
    return Position(
        dx: canvasController!.value.row0.w / minZoom,
        dy: canvasController!.value.row1.w / minZoom,
        tile: '');
  }

  String getTile(Offset dragOffset) {
    String tile = 'open';

    if (grass.contains(dragOffset)) {
      tile = 'grass';
    }

    return tile;
  }
}

class MapList {
  static MapInfo oldRuins = MapInfo(
    mapSize: 320,
  );
}


//TODO FIX ZOOM TO BE ABLE TO GET CURRENT ZOOM