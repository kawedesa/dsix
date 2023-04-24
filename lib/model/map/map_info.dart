import 'package:dsix/model/map/map_list.dart';
import 'package:dsix/model/map/map_tile.dart';
import 'package:flutter/material.dart';
import '../combat/position.dart';

class MapInfo {
  double zoom = 8;
  MapTile map = MapTile.empty();
  TransformationController? canvasController;

  void setMap(String mapName) {
    map = MapList().getMap(mapName);
    canvasController ??= TransformationController(
        Matrix4(zoom, 0, 0, 0, 0, zoom, 0, 0, 0, 0, zoom, 0, 0, 0, 0, 1));
  }

  void changeZoom(double value) {
    zoom += value;
    if (zoom < 4) {
      zoom = 4;
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

    if (map.grass.contains(dragOffset)) {
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
