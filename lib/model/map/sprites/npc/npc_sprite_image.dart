import 'dart:async';
import 'dart:math';
import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/model/effect/effect.dart';
import 'package:dsix/model/map/map_animations/sine_curve.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/map/ui/effects_ui.dart';
import 'package:dsix/shared/images/npc_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

import '../hit_box_sprite.dart';

class NpcSpriteImage extends StatefulWidget {
  final Npc npc;
  const NpcSpriteImage({super.key, required this.npc});

  @override
  State<NpcSpriteImage> createState() => _NpcSpriteImageState();
}

class _NpcSpriteImageState extends State<NpcSpriteImage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  double animOffset = Random().nextDouble();
  int currentLog = 0;
  bool hit = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void refresh() {
    setState(() {});
  }

  double shake(double value) {
    double speed = value + animOffset;

    if (speed > 1) {
      speed -= 1;
    }
    return const SineCurve(count: 1).transform(speed);
  }

  void checkBattleLog(List<BattleLog> battleLog, Function refresh) {
    if (battleLog.isEmpty) {
      return;
    }
    if (currentLog == battleLog.last.id) {
      return;
    }

    currentLog = battleLog.last.id;

    if (battleLog.last.targets.isEmpty) {
      return;
    }

    for (Target target in battleLog.last.targets) {
      String id = widget.npc.id.toString();
      if (target.id != id) {
        continue;
      }

      if (target.life == 0 && battleLog.last.attackInfo.attack.name == '') {
        continue;
      }

      Timer(const Duration(milliseconds: 500), () {
        hit = true;
        _controller.forward();
        refresh();
      });

      Timer(const Duration(milliseconds: 800), () {
        hit = false;
        _controller.reset();
        refresh();
      });
    }
  }

  Color getEffectsColor(List<Effect> effects) {
    if (effects.isEmpty) {
      return Colors.transparent;
    }
    int a = 0;
    int r = 255;
    int g = 255;
    int b = 255;

    for (Effect effect in effects) {
      switch (effect.name) {
        case 'burn':
          a = 75;
          r -= 68;
          g -= 175;
          b -= 255;

          break;
        case 'poison':
          a = 75;
          r -= 192;
          g -= 158;
          b -= 255;
          break;
      }
    }

    if (hit) {
      a = 75;
      r = 255;
      g = 255;
      b = 255;
    }

    return Color.fromARGB(a, r, g, b);
  }

  @override
  Widget build(BuildContext context) {
    final battleLog = Provider.of<List<BattleLog>>(context);
    checkBattleLog(battleLog, refresh);

    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(bottom: widget.npc.size * 0.6),
            child: TransparentPointer(
              transparent: true,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: (widget.npc.invisible) ? 0.7 : 1.0,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) => Transform.translate(
                    offset: Offset(
                      0,
                      shake(_controller.value),
                    ),
                    child: child,
                  ),
                  child: NpcImage(
                    name: widget.npc.name,
                    size: widget.npc.size,
                    color: getEffectsColor(widget.npc.effects.currentEffects),
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: EffectsUi(
                effects: widget.npc.effects.currentEffects,
                tempArmor: widget.npc.attributes.defense.tempArmor,
                tempVision: widget.npc.attributes.vision.tempVision),
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: HitBoxSprite(
              size: widget.npc.size,
              hitBox: widget.npc.hitBox.npcHitBox(widget.npc.name),
            )),
      ],
    );
  }
}
