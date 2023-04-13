import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/shared/images/npc_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class NpcSpriteImage extends StatelessWidget {
  final Npc npc;
  const NpcSpriteImage({super.key, required this.npc});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(bottom: npc.size * 0.6),
        child: TransparentPointer(
          transparent: true,
          child: NpcImage(
            npc: npc,
            size: npc.size,
          ),
        ),
      ),
    );
  }
}
