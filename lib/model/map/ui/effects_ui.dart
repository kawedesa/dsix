import 'package:dsix/model/effect/effect.dart';
import 'package:dsix/model/map/map_text.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EffectsUi extends StatelessWidget {
  final List<Effect> effects;
  final int tempArmor;
  final int tempVision;
  const EffectsUi(
      {super.key,
      required this.effects,
      required this.tempArmor,
      required this.tempVision});

  @override
  Widget build(BuildContext context) {
    List<Widget> effectsIcons = [];

    if (tempArmor != 0) {
      effectsIcons.add(SpriteEffects(
          effect: Effect(
        name: 'tempArmor',
        value: tempArmor,
        countdown: tempArmor,
      )));
    }
    if (tempVision != 0) {
      effectsIcons.add(SpriteEffects(
          effect: Effect(
        name: 'tempVision',
        value: 0,
        countdown: 0,
      )));
    }
    for (Effect effect in effects) {
      if (effect.name == 'illusion') {
        continue;
      }
      effectsIcons.add(SpriteEffects(effect: effect));
    }

    return SizedBox(
      width: 4.0 * effectsIcons.length,
      height: 4.0 * effectsIcons.length,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: effectsIcons,
      ),
    );
  }
}

class SpriteEffects extends StatefulWidget {
  final Effect effect;
  const SpriteEffects({super.key, required this.effect});

  @override
  State<SpriteEffects> createState() => _SpriteEffectsState();
}

class _SpriteEffectsState extends State<SpriteEffects>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..forward();
    _opacity = Tween<double>(begin: 0, end: 1).animate(_controller);
    _scale = Tween<double>(begin: 2, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: ScaleTransition(
        scale: _scale,
        child: SizedBox(
          width: 4,
          height: 4,
          child: Stack(
            children: [
              SvgPicture.asset(
                AppImages().getEffectIcon(widget.effect.name),
                width: 3.5,
                height: 3.5,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: MapText(
                  text: (widget.effect.countdown > 0)
                      ? widget.effect.countdown.toString()
                      : '',
                  fontSize: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
