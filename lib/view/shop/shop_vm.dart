class ShopVM {
  int selectedMenu = 0;
  String menuTitle = 'weapon';

  void changeMenu(int menuIndex) {
    switch (menuIndex) {
      case 0:
        selectedMenu = 0;
        menuTitle = 'weapon';
        break;
      case 1:
        selectedMenu = 1;
        menuTitle = 'armor';
        break;
      case 2:
        selectedMenu = 2;
        menuTitle = 'consumables';
        break;
    }
  }
}
