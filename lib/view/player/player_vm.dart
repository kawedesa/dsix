import 'package:flutter/material.dart';

import '../../model/player/player.dart';
import '../home/home_view.dart';

class PlayerVM {
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  int selectedPage = 0;

  String pageTitle = 'inventory';

  void changePage(int pageIndex) {
    selectedPage = pageIndex;
    changePageTitle();
    pageController.animateToPage(selectedPage,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void getReady(Player player) {
    player.finishCharacter();
    player.update();
  }

  void changePageTitle() {
    switch (selectedPage) {
      case 0:
        pageTitle = 'inventory';
        break;
      case 1:
        pageTitle = 'shop';
        break;
    }
  }

  void goToHomeView(context) {
    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const HomeView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(-1.0, 0.0);
        var end = const Offset(0.0, 0.0);
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );

    Navigator.of(context).push(newRoute);
  }
}
