import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NpcImage extends StatelessWidget {
  final Npc npc;
  final double size;
  const NpcImage({super.key, required this.npc, required this.size});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppImages().getNpcSprite(
        npc.name,
      ),
      width: size,
      height: size,
    );
  }
}
