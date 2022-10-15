import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/layout/app_line_divider_horizontal.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/app_widgets/text/app_text.dart';
import 'package:dsix/shared/app_widgets/text/app_title.dart';
import 'package:dsix/view/shop/shop_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../shared/app_widgets/dialog/app_shop_dialog.dart';

class ShopView extends StatefulWidget {
  final Function() refresh;

  const ShopView({Key? key, required this.refresh}) : super(key: key);

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  final ShopVM _shopVM = ShopVM();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    _shopVM.setItemList();

    return Column(
      children: [
        const AppSeparatorVertical(
          value: 0.02,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.shortestSide * 0.8,
          height: MediaQuery.of(context).size.shortestSide * 0.075,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppCircularButton(
                icon: AppImages.meleeWeaponMenu,
                iconColor: user.darkColor,
                borderColor:
                    (_shopVM.selectedMenu == 0) ? user.lightColor : user.color,
                color: user.color,
                size: 0.075,
                onTap: () {
                  setState(() {
                    _shopVM.changeMenu(0);
                  });
                },
              ),
              AppCircularButton(
                icon: AppImages.rangedWeaponMenu,
                iconColor: user.darkColor,
                borderColor:
                    (_shopVM.selectedMenu == 1) ? user.lightColor : user.color,
                color: user.color,
                size: 0.075,
                onTap: () {
                  setState(() {
                    _shopVM.changeMenu(1);
                  });
                },
              ),
              AppCircularButton(
                icon: AppImages.armorMenu,
                iconColor: user.darkColor,
                borderColor:
                    (_shopVM.selectedMenu == 2) ? user.lightColor : user.color,
                color: user.color,
                size: 0.075,
                onTap: () {
                  setState(() {
                    _shopVM.changeMenu(2);
                  });
                },
              ),
              AppCircularButton(
                icon: AppImages.consumableMenu,
                iconColor: user.darkColor,
                borderColor:
                    (_shopVM.selectedMenu == 3) ? user.lightColor : user.color,
                color: user.color,
                size: 0.075,
                onTap: () {
                  setState(() {
                    _shopVM.changeMenu(3);
                  });
                },
              ),
            ],
          ),
        ),
        const AppSeparatorVertical(
          value: 0.02,
        ),
        AppLineDividerHorizontal(color: user.color, value: 2),
        const AppSeparatorVertical(
          value: 0.02,
        ),
        AppTitle(title: _shopVM.menuTitle, color: user.color),
        const AppSeparatorVertical(
          value: 0.02,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.6,
          child: GridView.count(
            physics: const ScrollPhysics(),
            crossAxisCount: (MediaQuery.of(context).size.width * 0.01).toInt(),
            mainAxisSpacing: MediaQuery.of(context).size.height * 0.025,
            crossAxisSpacing: MediaQuery.of(context).size.width * 0.001,
            children: List.generate(_shopVM.itemList.length, (index) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AppShopDialog(
                        item: _shopVM.itemList[index],
                        color: user.color,
                        darkColor: user.darkColor,
                        buy: () {
                          _shopVM.buyItem(
                              _shopVM.itemList[index], user.player!);
                          widget.refresh();
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.shortestSide * 0.005,
                  height: MediaQuery.of(context).size.shortestSide * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SvgPicture.asset(
                          _shopVM.itemList[index].icon,
                          color: Colors.white,
                        ),
                      ),
                      AppText(
                          text: _shopVM.itemList[index].value.toString(),
                          fontSize: 0.025,
                          letterSpacing: 0.004,
                          color: user.color),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
