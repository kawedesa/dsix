import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_widgets/layout/app_line_divider_vertical.dart';
import 'package:flutter/material.dart';
import '../../../../shared/app_layout.dart';
import '../../../../shared/app_widgets/layout/app_line_divider_horizontal.dart';
import '../../../../shared/app_widgets/layout/app_separator_vertical.dart';
import '../../../../shared/app_widgets/dialog/dialog_title.dart';

class ObjectCreationDialog extends StatefulWidget {
  // final Function(Npc) chooseNpc;
  const ObjectCreationDialog({
    super.key,
    // required this.chooseNpc,
  });

  @override
  State<ObjectCreationDialog> createState() => _ObjectCreationDialogState();
}

class _ObjectCreationDialogState extends State<ObjectCreationDialog> {
  // Npc? selectedNpc;

  @override
  Widget build(BuildContext context) {
    // selectedNpc ??= NpcList().getNpcList().first;

    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: AppLayout.shortest(context) * 0.6,
        decoration: BoxDecoration(
          color: AppColors.uiColor,
          border: Border.all(
            color: AppColors.uiColor,
            width: AppLayout.shortest(context) * 0.005,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const DialogTitle(
              color: AppColors.uiColor,
              title: 'object',
            ),
            Container(
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppSeparatorVertical(value: 0.025),
                  // SizedBox(
                  //   width: AppLayout.shortest(context) * 0.55,
                  //   child: GridView.count(
                  //     shrinkWrap: true,
                  //     physics: const ScrollPhysics(),
                  //     crossAxisCount: 6,
                  //     // crossAxisCount:
                  //     //     (AppLayout.avarage(context) * 0.006).toInt(),
                  //     mainAxisSpacing: AppLayout.height(context) * 0.01,
                  //     crossAxisSpacing: AppLayout.width(context) * 0.01,
                  //     children:
                  //         List.generate(NpcList().getNpcList().length, (index) {
                  //       return GestureDetector(
                  //         onTap: () {},
                  //         child: (selectedNpc!.race ==
                  //                 NpcList().getNpcList()[index].race)
                  //             ? AppCircularButton(
                  //                 color: AppColors.uiColor,
                  //                 borderColor: AppColors.uiColor,
                  //                 iconColor: AppColors.uiColorDark,
                  //                 icon: AppImages().getRaceIcon(
                  //                     NpcList().getNpcList()[index].race),
                  //                 size: 0.07,
                  //                 onTap: () {
                  //                   setState(() {
                  //                     selectedNpc =
                  //                         NpcList().getNpcList()[index];
                  //                   });
                  //                 },
                  //               )
                  //             : AppCircularButton(
                  //                 color: AppColors.uiColorDark,
                  //                 borderColor: AppColors.uiColor,
                  //                 iconColor: AppColors.uiColor,
                  //                 icon: AppImages().getRaceIcon(
                  //                     NpcList().getNpcList()[index].race),
                  //                 size: 0.07,
                  //                 onTap: () {
                  //                   setState(() {
                  //                     selectedNpc =
                  //                         NpcList().getNpcList()[index];
                  //                   });
                  //                 },
                  //               ),
                  //       );
                  //     }),
                  //   ),
                  // ),
                  const AppSeparatorVertical(value: 0.025),
                  const AppLineDividerHorizontal(
                      color: AppColors.uiColor, value: 5),
                  SizedBox(
                    height: AppLayout.height(context) * 0.35,
                    child: Row(
                      children: const [
                        Expanded(flex: 2, child: SizedBox()),
                        AppLineDividerVertical(
                            color: AppColors.uiColor, value: 2.5),
                        // Expanded(
                        //     flex: 3,
                        //     child: SizedBox(
                        //       child: Column(
                        //         children: [
                        //           const AppSeparatorVertical(value: 0.025),
                        //           AppBarTitle(
                        //             title: selectedNpc!.race,
                        //             color: AppColors.uiColor,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // DialogButton(
            //     color: AppColors.uiColor,
            //     buttonText: 'choose',
            //     onTap: () {
            //       widget.chooseNpc(selectedNpc!);
            //       Navigator.pop(context);
            //     }),
          ],
        ),
      ),
    );
  }
}
