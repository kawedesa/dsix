import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/shared_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/shared_widgets/layout/app_separator_vertical.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapMenu extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final Function() refresh;
  const MapMenu(
      {super.key,
      required this.color,
      required this.borderColor,
      required this.refresh});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.all(AppLayout.avarage(context) * 0.01),
        child: SizedBox(
          child: Column(
            children: [
              AppCircularButton(
                color: color.withAlpha(100),
                icon: AppImages.plus,
                iconColor: borderColor.withAlpha(200),
                borderColor: borderColor.withAlpha(200),
                size: 0.04,
                onTap: () {
                  user.mapInfo.changeZoom(2);
                  refresh();
                },
              ),
              const AppSeparatorVertical(value: 0.01),
              AppCircularButton(
                color: color.withAlpha(100),
                icon: AppImages.minus,
                iconColor: borderColor.withAlpha(200),
                borderColor: borderColor.withAlpha(200),
                size: 0.04,
                onTap: () {
                  user.mapInfo.changeZoom(-2);
                  refresh();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
