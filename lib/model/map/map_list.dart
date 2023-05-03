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
      case 'crossroads':
        map = crossroads;
        break;
    }
    return map;
  }

  List<MapTile> availableMaps = [
    empty,
    oldRuins,
    crossroads,
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

  static MapTile crossroads = MapTile(
    name: 'crossroads',
    size: 620,
    grass: Path()
      ..moveTo(360, 25)
      ..lineTo(360, 40)
      ..lineTo(400, 40)
      ..lineTo(400, 25)
      ..lineTo(380, 20)
      ..close()
      //
      ..moveTo(500, 220)
      ..lineTo(532, 220)
      ..lineTo(536, 216)
      ..lineTo(536, 208)
      ..lineTo(524, 204)
      ..lineTo(504, 204)
      ..lineTo(500, 212)
      ..close()
      //
      ..moveTo(572, 276)
      ..lineTo(588, 276)
      ..lineTo(596, 268)
      ..lineTo(568, 240)
      ..lineTo(560, 240)
      ..lineTo(548, 252)
      ..close()
      //
      ..moveTo(260, 212)
      ..lineTo(284, 212)
      ..lineTo(280, 216)
      ..lineTo(312, 216)
      ..lineTo(308, 212)
      ..lineTo(320, 212)
      ..lineTo(320, 200)
      ..lineTo(308, 192)
      ..lineTo(256, 192)
      ..lineTo(256, 208)
      ..close()
      //
      ..moveTo(240, 280)
      ..lineTo(272, 280)
      ..lineTo(272, 264)
      ..lineTo(240, 264)
      ..lineTo(236, 268)
      ..lineTo(236, 276)
      ..close()
      //
      ..moveTo(112, 324)
      ..lineTo(116, 324)
      ..lineTo(120, 328)
      ..lineTo(152, 328)
      ..lineTo(152, 312)
      ..lineTo(112, 312)
      ..close()
      //
      ..moveTo(0, 458)
      ..lineTo(52, 460)
      ..lineTo(60, 452)
      ..lineTo(76, 452)
      ..lineTo(68, 444)
      ..lineTo(76, 436)
      ..lineTo(76, 420)
      ..lineTo(64, 408)
      ..lineTo(0, 408)
      ..close()
      //
      ..moveTo(144, 488)
      ..lineTo(152, 496)
      ..lineTo(240, 496)
      ..lineTo(244, 492)
      ..lineTo(244, 476)
      ..lineTo(220, 468)
      ..lineTo(204, 468)
      ..lineTo(196, 476)
      ..lineTo(188, 468)
      ..lineTo(164, 468)
      ..close()
      //

      ..moveTo(288, 584)
      ..lineTo(248, 552)
      ..lineTo(248, 536)
      ..lineTo(312, 536)
      ..lineTo(332, 556)
      ..lineTo(316, 572)
      ..lineTo(316, 584)
      ..close()
      //
      ..moveTo(284, 452)
      ..lineTo(300, 436)
      ..lineTo(324, 428)
      ..lineTo(356, 436)
      ..lineTo(364, 444)
      ..lineTo(364, 452)
      ..lineTo(348, 452)
      ..lineTo(352, 456)
      ..lineTo(288, 456)
      ..close()
      //
      ..moveTo(384, 488)
      ..lineTo(404, 468)
      ..lineTo(468, 468)
      ..lineTo(488, 488)
      ..lineTo(488, 504)
      ..lineTo(464, 504)
      ..lineTo(460, 508)
      ..lineTo(428, 508)
      ..lineTo(432, 504)
      ..lineTo(400, 504)
      ..close()
      //
      ..moveTo(376, 344)
      ..lineTo(396, 364)
      ..lineTo(436, 364)
      ..lineTo(452, 348)
      ..lineTo(452, 340)
      ..lineTo(436, 324)
      ..lineTo(396, 324)
      ..close(),
  );
}
