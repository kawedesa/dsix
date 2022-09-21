import 'package:flutter/material.dart';

class PlayerVM {
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  int selectedPage = 0;

  String pageTitle = 'profile';

  void changePage(int pageIndex) {
    selectedPage = pageIndex;
    changePageTitle();
    pageController.animateToPage(selectedPage,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void changePageTitle() {
    switch (selectedPage) {
      case 0:
        pageTitle = 'profile';
        break;
      case 1:
        pageTitle = 'inventory';
        break;
      case 2:
        pageTitle = 'shop';
        break;
    }
  }
}
