import 'package:dsix/model/map/map_tile.dart';
import 'package:flutter/material.dart';

class MapList {
  MapTile getMap(String mapName) {
    MapTile map = MapTile.empty();

    switch (mapName) {
      case 'empty':
        map = empty;
        break;
      case 'old ruins':
        map = oldRuins;
        break;
    }
    return map;
  }

  List<MapTile> availableMaps = [
    empty,
    oldRuins,
  ];

  static MapTile empty = MapTile(
    name: 'empty',
    size: 640,
    grass: Path(),
  );

  static MapTile oldRuins = MapTile(
    name: 'old ruins',
    size: 320,
    grass: Path()
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
      ..lineTo(32, 136),
  );
}
