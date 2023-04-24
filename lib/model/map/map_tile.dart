import 'package:flutter/material.dart';

class MapTile {
  String name;
  double size;
  Path grass;
  MapTile({required this.name, required this.size, required this.grass});

  factory MapTile.empty() {
    return MapTile(name: '', size: 0, grass: Path());
  }
}
