class AppImages {
  //UI
  static const logo = 'assets/images/ui/logo.svg';
  static const cancel = 'assets/images/ui/cancel.svg';
  static const duplicate = 'assets/images/ui/duplicate.svg';
  static const confirm = 'assets/images/ui/confirm.svg';
  static const left = 'assets/images/ui/left.svg';
  static const right = 'assets/images/ui/right.svg';
  static const locked = 'assets/images/ui/locked.svg';
  static const unlocked = 'assets/images/ui/unlocked.svg';

  static const power = 'assets/images/ui/power.svg';
  static const defense = 'assets/images/ui/defense.svg';
  static const vision = 'assets/images/ui/vision.svg';
  static const movement = 'assets/images/ui/movement.svg';

  static const pDamage = 'assets/images/ui/pDamage.svg';
  static const mDamage = 'assets/images/ui/mDamage.svg';
  static const pArmor = 'assets/images/ui/pArmor.svg';
  static const mArmor = 'assets/images/ui/mArmor.svg';
  static const health = 'assets/images/ui/health.svg';
  static const weight = 'assets/images/ui/weight.svg';
  static const money = 'assets/images/ui/money.svg';
  static const minRange = 'assets/images/ui/minRange.svg';
  static const maxRange = 'assets/images/ui/maxRange.svg';

  static const tempVision = 'assets/images/ui/tempVision.svg';
  static const tempArmor = 'assets/images/ui/tempArmor.svg';
  static const poison = 'assets/images/ui/poison.svg';
  static const bleed = 'assets/images/ui/poison.svg';

  String getEffectIcon(String effect) {
    String effectIcon = '';

    switch (effect) {
      case 'bleed':
        effectIcon = bleed;
        break;
      case 'poison':
        effectIcon = poison;
        break;
      case 'tempArmor':
        effectIcon = tempArmor;
        break;
      case 'tempVision':
        effectIcon = tempVision;
        break;
    }

    return effectIcon;
  }

  static const minus = 'assets/images/ui/minus.svg';
  static const plus = 'assets/images/ui/plus.svg';

  static const settings = 'assets/images/ui/settings.svg';
  static const map = 'assets/images/ui/map.svg';
  static const profile = 'assets/images/ui/profile.svg';
  static const spawner = 'assets/images/ui/spawner.svg';
  static const npc = 'assets/images/ui/npc.svg';
  static const building = 'assets/images/ui/building.svg';
  static const turn = 'assets/images/ui/turn.svg';

  static const shop = 'assets/images/ui/shop.svg';
  static const meleeWeaponMenu = 'assets/images/ui/meleeWeaponMenu.svg';
  static const rangedWeaponMenu = 'assets/images/ui/rangedWeaponMenu.svg';
  static const armorMenu = 'assets/images/ui/armorMenu.svg';
  static const consumableMenu = 'assets/images/ui/consumableMenu.svg';
  static const empty = 'assets/images/ui/empty.svg';

  //Inventory
  static const inventory = 'assets/images/ui/inventory.svg';
  static const bodySlot = 'assets/images/ui/bodySlot.svg';
  static const feetSlot = 'assets/images/ui/feetSlot.svg';
  static const handSlot = 'assets/images/ui/handSlot.svg';
  static const headSlot = 'assets/images/ui/headSlot.svg';
  static const mainHandSlot = 'assets/images/ui/mainHandSlot.svg';
  static const offHandSlot = 'assets/images/ui/offHandSlot.svg';

  //Item

  static const punch = 'assets/images/items/punch.svg';

  //Light Weapons
  static const dagger = 'assets/images/items/dagger.svg';
  static const magicDagger = 'assets/images/items/magicDagger.svg';
  static const baton = 'assets/images/items/baton.svg';
  static const mace = 'assets/images/items/mace.svg';
  static const claw = 'assets/images/items/claw.svg';
  static const axe = 'assets/images/items/axe.svg';
  static const magicAxe = 'assets/images/items/magicAxe.svg';
  static const shortSword = 'assets/images/items/shortSword.svg';
  static const shortSpear = 'assets/images/items/shortSpear.svg';
  static const rapier = 'assets/images/items/rapier.svg';
  static const sword = 'assets/images/items/sword.svg';
  static const morningStar = 'assets/images/items/morningStar.svg';
  static const saber = 'assets/images/items/saber.svg';
  static const longSword = 'assets/images/items/longSword.svg';
  static const magicSword = 'assets/images/items/magicSword.svg';

  //Heavy Weapons
  static const longSpear = 'assets/images/items/longSpear.svg';
  static const quarterstaff = 'assets/images/items/quarterstaff.svg';
  static const doubleSword = 'assets/images/items/doubleSword.svg';
  static const trident = 'assets/images/items/trident.svg';
  static const battleAxe = 'assets/images/items/battleAxe.svg';
  static const halberd = 'assets/images/items/halberd.svg';
  static const warHammer = 'assets/images/items/warHammer.svg';
  static const greatSword = 'assets/images/items/greatSword.svg';

  //Ranged Weapons
  static const blowgun = 'assets/images/items/blowgun.svg';
  static const boomerang = 'assets/images/items/boomerang.svg';
  static const javelins = 'assets/images/items/javelins.svg';
  static const grenades = 'assets/images/items/grenades.svg';
  static const shortBow = 'assets/images/items/shortBow.svg';
  static const kunai = 'assets/images/items/kunai.svg';
  static const handCrossbow = 'assets/images/items/handCrossbow.svg';
  static const longBow = 'assets/images/items/longBow.svg';
  static const greatBow = 'assets/images/items/greatBow.svg';
  static const lightCrossbow = 'assets/images/items/lightCrossbow.svg';
  static const handCannon = 'assets/images/items/handCannon.svg';
  static const heavyCrossbow = 'assets/images/items/heavyCrossbow.svg';
  static const musket = 'assets/images/items/musket.svg';

  //Magic Weapons
  static const magicOrb = 'assets/images/items/magicOrb.svg';
  static const wand = 'assets/images/items/wand.svg';
  static const spellBook = 'assets/images/items/spellBook.svg';
  static const magicStaff = 'assets/images/items/magicStaff.svg';

  //Armor
  static const helmet = 'assets/images/items/helmet.svg';
  static const gloves = 'assets/images/items/gloves.svg';
  static const boots = 'assets/images/items/boots.svg';
  static const lightArmor = 'assets/images/items/lightArmor.svg';
  static const buckler = 'assets/images/items/buckler.svg';
  static const magicSandals = 'assets/images/items/magicSandals.svg';
  static const lightShield = 'assets/images/items/lightShield.svg';
  static const magicRobe = 'assets/images/items/magicRobe.svg';
  static const heavyShield = 'assets/images/items/heavyShield.svg';
  static const fullHelmet = 'assets/images/items/fullHelmet.svg';
  static const magicShield = 'assets/images/items/magicShield.svg';
  static const heavyArmor = 'assets/images/items/heavyArmor.svg';

  //Ancient
  static const ancientGloves = 'assets/images/items/ancientGloves.svg';
  static const ancientBoots = 'assets/images/items/ancientBoots.svg';
  static const ancientHelmet = 'assets/images/items/ancientHelmet.svg';
  static const ancientShield = 'assets/images/items/ancientShield.svg';
  static const ancientArmor = 'assets/images/items/ancientArmor.svg';
  static const ancientSpellBook = 'assets/images/items/ancientSpellbook.svg';
  static const ancientSword = 'assets/images/items/ancientSword.svg';
  static const ancientWarAxe = 'assets/images/items/ancientWarAxe.svg';
  static const ancientBow = 'assets/images/items/ancientBow.svg';

  //Consumable
  static const ward = 'assets/images/items/ward.svg';
  static const food = 'assets/images/items/food.svg';
  static const healingPotion = 'assets/images/items/healingPotion.svg';

  String getItemIcon(String item) {
    String itemIcon = '';

    switch (item) {
      case 'empty':
        itemIcon = punch;
        break;

      //MELEE
      case 'mace':
        itemIcon = mace;
        break;
      case 'magic dagger':
        itemIcon = magicDagger;
        break;
      case 'short sword':
        itemIcon = shortSword;
        break;
      case 'short spear':
        itemIcon = shortSpear;
        break;
      case 'magic sword':
        itemIcon = magicSword;
        break;
      case 'morning star':
        itemIcon = morningStar;
        break;

      //RANGED

      case 'magic orb':
        itemIcon = magicOrb;
        break;
      case 'grenades':
        itemIcon = grenades;
        break;
      case 'wand':
        itemIcon = wand;
        break;
      case 'short bow':
        itemIcon = shortBow;
        break;
      case 'long bow':
        itemIcon = longBow;
        break;
      case 'musket':
        itemIcon = musket;
        break;

      //ARMOR
      case 'boots':
        itemIcon = boots;
        break;
      case 'gloves':
        itemIcon = gloves;
        break;
      case 'buckler':
        itemIcon = buckler;
        break;
      case 'magic sandals':
        itemIcon = magicSandals;
        break;
      case 'helmet':
        itemIcon = helmet;
        break;
      case 'light shield':
        itemIcon = lightShield;
        break;
      case 'magic robe':
        itemIcon = magicRobe;
        break;
      case 'light armor':
        itemIcon = lightArmor;
        break;
      case 'heavy shield':
        itemIcon = heavyShield;
        break;
      case 'full helmet':
        itemIcon = fullHelmet;
        break;
      case 'magic shield':
        itemIcon = magicShield;
        break;
      case 'heavy armor':
        itemIcon = heavyArmor;
        break;
    }

    return itemIcon;
  }

  //Sprites
  //OBJECTS
  static const grave = 'assets/images/sprites/objects/grave.svg';
  static const graveColor = 'assets/images/sprites/objects/graveColor.svg';

  static const chestClosed = 'assets/images/sprites/objects/chestClosed.svg';
  static const chestOpen = 'assets/images/sprites/objects/chestOpen.svg';

  //PLAYERS

  static const dwarfBody = 'assets/images/sprites/players/dwarfBody.svg';
  static const dwarfHead = 'assets/images/sprites/players/dwarfHead.svg';

  static const orcBody = 'assets/images/sprites/players/orcBody.svg';
  static const orcHead = 'assets/images/sprites/players/orcHead.svg';

  static const elfBody = 'assets/images/sprites/players/elfBody.svg';
  static const elfHead = 'assets/images/sprites/players/elfHead.svg';

  //NPCS
  static const zombie = 'assets/images/sprites/npcs/zombie.svg';
  static const giantBat = 'assets/images/sprites/npcs/giantBat.svg';
  static const skeleton = 'assets/images/sprites/npcs/skeleton.svg';
  static const skeletonMage = 'assets/images/sprites/npcs/skeletonMage.svg';
  static const giantFrog = 'assets/images/sprites/npcs/giantFrog.svg';
  static const goblin = 'assets/images/sprites/npcs/goblin.svg';
  static const beast = 'assets/images/sprites/npcs/beast.svg';
  static const explosiveLizzard =
      'assets/images/sprites/npcs/explosiveLizzard.svg';
  static const wraith = 'assets/images/sprites/npcs/wraith.svg';
  static const golen = 'assets/images/sprites/npcs/golen.svg';

  String getNpcIcon(String npc) {
    String npcIcon = '';

    switch (npc) {
      case 'zombie':
        npcIcon = zombie;
        break;
      case 'giant bat':
        npcIcon = giantBat;
        break;
      case 'skeleton':
        npcIcon = skeleton;
        break;
      case 'skeleton mage':
        npcIcon = skeletonMage;
        break;
      case 'giant frog':
        npcIcon = giantFrog;
        break;

      case 'goblin':
        npcIcon = goblin;
        break;
      case 'beast':
        npcIcon = beast;
        break;
      case 'explosive lizzard':
        npcIcon = explosiveLizzard;
        break;

      case 'wraith':
        npcIcon = wraith;
        break;

      case 'golen':
        npcIcon = golen;
        break;
    }

    return npcIcon;
  }

  //BUILDINGS
  static const blackTablet = 'assets/images/sprites/buildings/blackTablet.svg';
  static const divineAltar = 'assets/images/sprites/buildings/divineAltar.svg';
  static const earthAltar = 'assets/images/sprites/buildings/earthAltar.svg';
  static const sacrificeAltar =
      'assets/images/sprites/buildings/sacrificeAltar.svg';

  String getBuildingIcon(String building) {
    String buildingIcon = '';

    switch (building) {
      case 'black tablet':
        buildingIcon = blackTablet;
        break;
      case 'divine altar':
        buildingIcon = divineAltar;
        break;
      case 'earth altar':
        buildingIcon = earthAltar;
        break;
      case 'sacrifice altar':
        buildingIcon = sacrificeAltar;
        break;
    }

    return buildingIcon;
  }

  //Map
  static const oldRuins = 'assets/images/maps/oldRuins.svg';

  String getMapImage(String map) {
    String mapImage = '';

    switch (map) {
      case 'old ruins':
        mapImage = oldRuins;
        break;
    }

    return mapImage;
  }
}
