import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/player/player_sprite_head.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerSprite extends StatefulWidget {
  final String race;

  const PlayerSprite({Key? key, required this.race}) : super(key: key);

  @override
  State<PlayerSprite> createState() => _PlayerSpriteState();
}

class _PlayerSpriteState extends State<PlayerSprite> {
  String bodyImage() {
    String selectedImage = '';

    switch (widget.race) {
      case 'dwarf':
        selectedImage = AppImages.dwarfBody;
        break;
      case 'orc':
        selectedImage = AppImages.orcBody;
        break;
      case 'elf':
        selectedImage = AppImages.elfBody;
        break;
    }

    return selectedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          bodyImage(),
          width: AppLayout.shortest(context) * 0.5,
        ),
        PlayerSpriteHead(race: widget.race),
      ],
    );
  }
}
