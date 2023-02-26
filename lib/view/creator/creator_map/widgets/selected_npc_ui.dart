import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/text/app_text.dart';
import 'package:flutter/material.dart';
import 'life_bar.dart';

class SelectedNpcUi extends StatelessWidget {
  final Npc npc;

  const SelectedNpcUi({super.key, required this.npc});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(
        0.0,
        -0.9,
      ),
      child: SizedBox(
        width: AppLayout.shortest(context) * 0.3,
        height: AppLayout.shortest(context) * 0.05,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: AppText(
                text: npc.race.toUpperCase(),
                fontSize: 0.015,
                letterSpacing: 0.008,
                color: Colors.white,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: LifeBar(
                life: npc.life,
                width: AppLayout.shortest(context) * 0.3,
                height: AppLayout.shortest(context) * 0.015,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
