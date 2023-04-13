import 'package:dsix/model/user.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/layout/app_line_divider_horizontal.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/view/player/shop/shop_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopView extends StatefulWidget {
  final Function() refresh;

  const ShopView({
    Key? key,
    required this.refresh,
  }) : super(key: key);

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  final ShopVM _shopVM = ShopVM();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    _shopVM.setShopMenu();

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppSeparatorVertical(
            value: 0.01,
          ),
          SizedBox(
            width: AppLayout.shortest(context) * 0.8,
            height: AppLayout.avarage(context) * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppCircularButton(
                  icon: AppImages.menuLightWeapon,
                  iconColor: user.darkColor,
                  borderColor: (_shopVM.selectedMenu == 0)
                      ? user.lightColor
                      : user.color,
                  color: user.color,
                  size: 0.04,
                  onTap: () {
                    setState(() {
                      _shopVM.changeMenu(0);
                    });
                  },
                ),
                AppCircularButton(
                  icon: AppImages.menuHeavyWeapon,
                  iconColor: user.darkColor,
                  borderColor: (_shopVM.selectedMenu == 1)
                      ? user.lightColor
                      : user.color,
                  color: user.color,
                  size: 0.04,
                  onTap: () {
                    setState(() {
                      _shopVM.changeMenu(1);
                    });
                  },
                ),
                AppCircularButton(
                  icon: AppImages.menuRangedWeapon,
                  iconColor: user.darkColor,
                  borderColor: (_shopVM.selectedMenu == 2)
                      ? user.lightColor
                      : user.color,
                  color: user.color,
                  size: 0.04,
                  onTap: () {
                    setState(() {
                      _shopVM.changeMenu(2);
                    });
                  },
                ),
                AppCircularButton(
                  icon: AppImages.menuMagicWeapon,
                  iconColor: user.darkColor,
                  borderColor: (_shopVM.selectedMenu == 3)
                      ? user.lightColor
                      : user.color,
                  color: user.color,
                  size: 0.04,
                  onTap: () {
                    setState(() {
                      _shopVM.changeMenu(3);
                    });
                  },
                ),
                AppCircularButton(
                  icon: AppImages.menuArmor,
                  iconColor: user.darkColor,
                  borderColor: (_shopVM.selectedMenu == 4)
                      ? user.lightColor
                      : user.color,
                  color: user.color,
                  size: 0.04,
                  onTap: () {
                    setState(() {
                      _shopVM.changeMenu(4);
                    });
                  },
                ),
                AppCircularButton(
                  icon: AppImages.menuConsumable,
                  iconColor: user.darkColor,
                  borderColor: (_shopVM.selectedMenu == 5)
                      ? user.lightColor
                      : user.color,
                  color: user.color,
                  size: 0.04,
                  onTap: () {
                    setState(() {
                      _shopVM.changeMenu(5);
                    });
                  },
                ),
              ],
            ),
          ),
          const AppSeparatorVertical(value: 0.01),
          AppLineDividerHorizontal(color: user.color, value: 4),
          const AppSeparatorVertical(value: 0.02),
          SizedBox(
            height: AppLayout.height(context) * 0.6,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppCircularButton(
                    color: Colors.transparent,
                    borderColor: user.color,
                    iconColor: user.color,
                    icon: AppImages.left,
                    onTap: () {
                      setState(() {
                        _shopVM.changeSelectedItem(-1);
                      });
                    },
                    size: 0.075),
                const AppSeparatorHorizontal(value: 0.05),
                _shopVM.getItems(context, user, widget.refresh),
                const AppSeparatorHorizontal(value: 0.05),
                AppCircularButton(
                    color: Colors.transparent,
                    borderColor: user.color,
                    iconColor: user.color,
                    icon: AppImages.right,
                    onTap: () {
                      setState(() {
                        _shopVM.changeSelectedItem(1);
                      });
                    },
                    size: 0.075),
              ],
            ),
          )
        ],
      ),
    );
  }
}
