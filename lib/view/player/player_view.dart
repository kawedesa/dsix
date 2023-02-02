import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/shared/app_widgets/text/app_text.dart';
import 'package:dsix/view/inventory/inventory_view.dart';
import 'package:dsix/view/player/player_vm.dart';
import 'package:dsix/view/shop/shop_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/app_colors.dart';
import '../../shared/app_widgets/text/app_bar_title.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({Key? key}) : super(key: key);

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  final PlayerVM _playerVM = PlayerVM();

  void refresh() {
    setState(() {});
  }

  void displaySnackBar(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: SizedBox(
          height: AppLayout.avarage(context) * 0.05,
          child: Center(
            child: AppText(
              text: text,
              fontSize: 0.03,
              letterSpacing: 0.005,
              color: Colors.white,
            ),
          )),
      backgroundColor: color,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: AppLayout.height(context) * 0.06,
        backgroundColor: user.color,
        centerTitle: false,
        title: AppBarTitle(
          title: _playerVM.pageTitle,
          color: user.darkColor,
        ),
        leading: Row(
          children: [
            const AppSeparatorHorizontal(
              value: 0.003,
            ),
            GestureDetector(
              onTap: () {
                if (user.player!.finished) {
                  _playerVM.goToHomeView(context);
                } else {
                  Navigator.pop(context);
                }
              },
              child: Icon(
                Icons.exit_to_app,
                color: user.darkColor,
                size: AppLayout.height(context) * 0.035,
              ),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppCircularButton(
                  icon: AppImages.health,
                  iconColor: user.darkColor,
                  color: Colors.transparent,
                  borderColor: user.darkColor,
                  size: 0.04),
              const AppSeparatorHorizontal(
                value: 0.01,
              ),
              AppText(
                text: '${user.player!.life.current}/${user.player!.life.max}',
                fontSize: 0.03,
                letterSpacing: 0.002,
                color: user.darkColor,
              ),
              const AppSeparatorHorizontal(
                value: 0.025,
              ),
              AppCircularButton(
                  icon: AppImages.weight,
                  iconColor: user.darkColor,
                  color: Colors.transparent,
                  borderColor: user.darkColor,
                  size: 0.04),
              const AppSeparatorHorizontal(
                value: 0.01,
              ),
              AppText(
                text:
                    '${user.player!.equipment.currentWeight}/${user.player!.equipment.maxWeight}',
                fontSize: 0.03,
                letterSpacing: 0.002,
                color: user.darkColor,
              ),
              const AppSeparatorHorizontal(
                value: 0.025,
              ),
              AppCircularButton(
                  icon: AppImages.money,
                  iconColor: user.darkColor,
                  color: Colors.transparent,
                  borderColor: user.darkColor,
                  size: 0.04),
              const AppSeparatorHorizontal(
                value: 0.01,
              ),
              AppText(
                text: '${user.player!.equipment.money}',
                fontSize: 0.03,
                letterSpacing: 0.002,
                color: user.darkColor,
              ),
              const AppSeparatorHorizontal(
                value: 0.05,
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: PageView(
          controller: _playerVM.pageController,
          children: [
            InventoryView(
              refresh: () => refresh(),
              displaySnackbar: (text, color) => displaySnackBar(text, color),
            ),
            ShopView(
              refresh: () => refresh(),
              displaySnackbar: (text, color) => displaySnackBar(text, color),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: user.color,
        height: AppLayout.height(context) * 0.1,
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppSeparatorHorizontal(value: 0.05),
              AppCircularButton(
                  onTap: () {
                    _playerVM.changePage(0);
                  },
                  icon: AppImages.inventory,
                  iconColor: user.darkColor,
                  color: Colors.transparent,
                  borderColor: user.darkColor,
                  size: 0.07),
              AppCircularButton(
                  onTap: () {
                    _playerVM.changePage(1);
                  },
                  icon: AppImages.shop,
                  iconColor: user.darkColor,
                  color: Colors.transparent,
                  borderColor: user.darkColor,
                  size: 0.07),
              (user.player!.finished)
                  ? AppCircularButton(
                      icon: AppImages.confirm,
                      iconColor: user.color,
                      color: AppColors.selected,
                      borderColor: AppColors.selected,
                      size: 0.07)
                  : AppCircularButton(
                      onTap: () {
                        setState(() {
                          _playerVM.getReady(user.player!);
                        });
                      },
                      icon: AppImages.confirm,
                      iconColor: user.darkColor,
                      color: user.color,
                      borderColor: user.darkColor,
                      size: 0.07),
              const AppSeparatorHorizontal(value: 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
