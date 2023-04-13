import 'package:dsix/model/game/game.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/app_widgets/button/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../shared/app_layout.dart';
import '../../../shared/app_widgets/button/app_circular_button.dart';
import '../../../shared/app_widgets/layout/app_separator_vertical.dart';
import 'creator_map_slection_vm.dart';

class CreatorMapSelection extends StatefulWidget {
  const CreatorMapSelection({Key? key}) : super(key: key);

  @override
  State<CreatorMapSelection> createState() => _CreatorMapSelectionState();
}

class _CreatorMapSelectionState extends State<CreatorMapSelection> {
  final CreatorMapSelectionVM _creatorMapSelectionVM = CreatorMapSelectionVM();

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);

    return Center(
      child: SizedBox(
        width: AppLayout.shortest(context) * 0.9,
        height: AppLayout.height(context) * 0.85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: AppLayout.shortest(context) * 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppCircularButton(
                      color: Colors.transparent,
                      borderColor: AppColors.uiColor,
                      iconColor: AppColors.uiColor,
                      icon: AppImages.left,
                      onTap: () {
                        setState(() {
                          // _raceVM.changeRace(-1);
                        });
                      },
                      size: 0.075),
                  SvgPicture.asset(
                    width: AppLayout.shortest(context) * 0.5,
                    height: AppLayout.shortest(context) * 0.5,
                    AppImages.oldRuins,
                  ),
                  AppCircularButton(
                      color: Colors.transparent,
                      borderColor: AppColors.uiColor,
                      iconColor: AppColors.uiColor,
                      icon: AppImages.right,
                      onTap: () {
                        setState(() {
                          // _raceVM.changeRace(1);
                        });
                      },
                      size: 0.075),
                ],
              ),
            ),
            const AppSeparatorVertical(value: 0.025),
            AppTextButton(
                buttonText: 'choose',
                color: AppColors.uiColor,
                onTap: () {
                  setState(() {
                    _creatorMapSelectionVM.chooseMap(game);
                  });
                }),
          ],
        ),
      ),
    );
  }
}
