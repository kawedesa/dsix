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
    return SizedBox(
      width: AppLayout.avarage(context) * 0.3,
      height: AppLayout.avarage(context) * 0.05,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AppText(
              text: npc.race.toUpperCase(),
              fontSize: 0.02,
              letterSpacing: 0.005,
              color: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: LifeBar(
              life: npc.life,
              width: AppLayout.avarage(context) * 0.3,
              height: AppLayout.avarage(context) * 0.015,
            ),
          ),
        ],
      ),
    );
  }
}
