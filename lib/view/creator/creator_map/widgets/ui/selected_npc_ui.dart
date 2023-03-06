import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/map/life_bar.dart';
import 'package:dsix/shared/app_widgets/text/app_text.dart';
import 'package:flutter/material.dart';

class SelectedNpcUi extends StatelessWidget {
  final Npc? npc;

  const SelectedNpcUi({super.key, required this.npc});

  @override
  Widget build(BuildContext context) {
    return (npc == null)
        ? const SizedBox()
        : Container(
            width: AppLayout.avarage(context) * 0.25,
            height: AppLayout.avarage(context) * 0.055,
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(150),
              border: Border.all(
                color: AppColors.uiColor,
                width: AppLayout.avarage(context) * 0.0025,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: AppText(
                      text: npc!.race.toUpperCase(),
                      fontSize: 0.0125,
                      letterSpacing: 0.0025,
                      color: Colors.white,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: LifeBar(
                      life: npc!.life,
                      width: AppLayout.avarage(context) * 0.18,
                      height: AppLayout.avarage(context) * 0.01,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
