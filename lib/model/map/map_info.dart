import 'package:flutter/material.dart';
import '../combat/position.dart';

class MapInfo {
  double mapSize;
  double zoom = 8;
  Path grass = Path();

  TransformationController? canvasController;

  MapInfo({required this.mapSize, this.canvasController});

  factory MapInfo.empty() {
    return MapInfo(mapSize: 0, canvasController: null);
  }

  void setMapInfo(String mapName) {
    canvasController ??= TransformationController(
        Matrix4(zoom, 0, 0, 0, 0, zoom, 0, 0, 0, 0, zoom, 0, 0, 0, 0, 1));

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

  void changeZoom(double value) {
    zoom += value;
    if (zoom < 8) {
      zoom = 8;
    }
    if (zoom > 20) {
      zoom = 20;
    }

    double dx = canvasController!.value.row0.w * zoom / (zoom - value);
    double dy = canvasController!.value.row1.w * zoom / (zoom - value);

    canvasController = TransformationController(
        Matrix4(zoom, 0, 0, 0, 0, zoom, 0, 0, 0, 0, zoom, 0, dx, dy, 0, 1));
  }

  Position getOnScreenPosition(Position position) {
    return Position(
        dx: (position.dx * zoom) + (getCanvasPosition().dx * zoom),
        dy: (position.dy * zoom) + (getCanvasPosition().dy * zoom),
        tile: '');
  }

  Position getCanvasPosition() {
    return Position(
        dx: canvasController!.value.row0.w / zoom,
        dy: canvasController!.value.row1.w / zoom,
        tile: '');
  }

  String getTile(Offset dragOffset) {
    String tile = 'open';

    if (grass.contains(dragOffset)) {
      tile = 'grass';
    }

    return tile;
  }

  Position getMousePosition(Offset mouseOffset) {
    Offset mousePosition = Offset(
        mouseOffset.dx / zoom - getCanvasPosition().dx,
        mouseOffset.dy / zoom - getCanvasPosition().dy - 50 / zoom);

    String tile = getTile(mousePosition);
    return Position(dx: mousePosition.dx, dy: mousePosition.dy, tile: tile);
  }
}

class MapList {
  static MapInfo oldRuins = MapInfo(
    mapSize: 320,
  );
}
