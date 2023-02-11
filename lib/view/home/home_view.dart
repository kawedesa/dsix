import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/view/home/widgets/home_menu.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(
          width: AppLayout.width(context),
          height: AppLayout.height(context),
          child: const Center(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeInOutBack,
              child: HomeMenu(),
            ),
          ),
        ),
      ),
    );
  }
}
