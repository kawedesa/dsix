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
  static const male = 'assets/images/ui/male.svg';
  static const female = 'assets/images/ui/female.svg';
  static const difficulty = 'assets/images/ui/difficulty.svg';

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
  static const placeHere = 'assets/images/ui/placeHere.svg';

  //EFFECTS
  static const effectTempVision = 'assets/images/ui/effectTempVision.svg';
  static const effectTempArmor = 'assets/images/ui/effectTempArmor.svg';
  static const effectPoison = 'assets/images/ui/effectPoison.svg';
  static const effectBleed = 'assets/images/ui/effectBleed.svg';
  static const effectVulnerable = 'assets/images/ui/effectVulnerable.svg';
  static const effectStun = 'assets/images/ui/effectStun.svg';
  static const effectWeaken = 'assets/images/ui/effectWeaken.svg';
  static const effectBurn = 'assets/images/ui/effectBurn.svg';

  String getEffectIcon(String effect) {
    String effectIcon = '';

    switch (effect) {
      case 'bleed':
        effectIcon = effectBleed;
        break;
      case 'poison':
        effectIcon = effectPoison;
        break;
      case 'tempArmor':
        effectIcon = effectTempArmor;
        break;
      case 'tempVision':
        effectIcon = effectTempVision;
        break;
      case 'vulnerable':
        effectIcon = effectVulnerable;
        break;
      case 'stun':
        effectIcon = effectStun;
        break;
      case 'weaken':
        effectIcon = effectWeaken;
        break;
      case 'burn':
        effectIcon = effectBurn;
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
  static const prop = 'assets/images/ui/prop.svg';
  static const turn = 'assets/images/ui/turn.svg';

  static const shop = 'assets/images/ui/shop.svg';
  static const menuLightWeapon = 'assets/images/ui/menuLightWeapon.svg';
  static const menuHeavyWeapon = 'assets/images/ui/menuHeavyWeapon.svg';
  static const menuRangedWeapon = 'assets/images/ui/menuRangedWeapon.svg';
  static const menuMagicWeapon = 'assets/images/ui/menuMagicWeapon.svg';
  static const menuArmor = 'assets/images/ui/menuArmor.svg';
  static const menuConsumable = 'assets/images/ui/menuConsumable.svg';
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
  static const batton = 'assets/images/items/batton.svg';
  static const dagger = 'assets/images/items/dagger.svg';
  static const flail = 'assets/images/items/flail.svg';
  static const gladius = 'assets/images/items/gladius.svg';
  static const mace = 'assets/images/items/mace.svg';
  static const morningStar = 'assets/images/items/morningStar.svg';
  static const nunchaku = 'assets/images/items/nunchaku.svg';
  static const poisonDagger = 'assets/images/items/poisonDagger.svg';
  static const rapier = 'assets/images/items/rapier.svg';
  static const saber = 'assets/images/items/saber.svg';
  static const sharpFist = 'assets/images/items/sharpFist.svg';
  static const shortSpear = 'assets/images/items/shortSpear.svg';
  static const shortSword = 'assets/images/items/shortSword.svg';
  static const talon = 'assets/images/items/talon.svg';
  static const woodAxe = 'assets/images/items/woodAxe.svg';

  //Heavy Weapons
  static const giantClub = 'assets/images/items/giantClub.svg';
  static const warHammer = 'assets/images/items/warHammer.svg';
  static const katana = 'assets/images/items/katana.svg';
  static const longSword = 'assets/images/items/longSword.svg';
  static const battleAxe = 'assets/images/items/battleAxe.svg';
  static const doubleSword = 'assets/images/items/doubleSword.svg';
  static const quarterstaff = 'assets/images/items/quarterstaff.svg';
  static const trident = 'assets/images/items/trident.svg';
  static const longSpear = 'assets/images/items/longSpear.svg';
  static const greatSword = 'assets/images/items/greatSword.svg';
  static const halberd = 'assets/images/items/halberd.svg';
  static const longAxe = 'assets/images/items/longAxe.svg';

  //Ranged Weapons
  static const boomerang = 'assets/images/items/boomerang.svg';
  static const compositeBow = 'assets/images/items/compositeBow.svg';
  static const handCannon = 'assets/images/items/handCannon.svg';
  static const handCrossbow = 'assets/images/items/handCrossbow.svg';
  static const heavyCrossbow = 'assets/images/items/heavyCrossbow.svg';
  static const javelins = 'assets/images/items/javelins.svg';
  static const kunai = 'assets/images/items/kunai.svg';
  static const lightCrossbow = 'assets/images/items/lightCrossbow.svg';
  static const longBow = 'assets/images/items/longBow.svg';
  static const musket = 'assets/images/items/musket.svg';
  static const poisonDart = 'assets/images/items/poisonDart.svg';
  static const shortBow = 'assets/images/items/shortBow.svg';
  static const whip = 'assets/images/items/whip.svg';

  //Magic Weapons
  static const magicOrb = 'assets/images/items/magicOrb.svg';
  static const wand = 'assets/images/items/wand.svg';
  static const spellBook = 'assets/images/items/spellBook.svg';
  static const magicStaff = 'assets/images/items/magicStaff.svg';

  //Armor
  static const strawHat = 'assets/images/items/strawHat.svg';
  static const hood = 'assets/images/items/hood.svg';
  static const helmet = 'assets/images/items/helmet.svg';
  static const fullHemlet = 'assets/images/items/fullHelmet.svg';
  static const shortGloves = 'assets/images/items/shortGloves.svg';
  static const leatherGloves = 'assets/images/items/leatherGloves.svg';
  static const gauntlet = 'assets/images/items/gauntlet.svg';
  static const spikyGauntlet = 'assets/images/items/spikyGauntlet.svg';
  static const boots = 'assets/images/items/boots.svg';
  static const heavyBoots = 'assets/images/items/heavyBoots.svg';
  static const sandals = 'assets/images/items/sandals.svg';
  static const shoes = 'assets/images/items/shoes.svg';
  static const lightArmor = 'assets/images/items/lightArmor.svg';
  static const heavyArmor = 'assets/images/items/heavyArmor.svg';
  static const robe = 'assets/images/items/robe.svg';
  static const battleRobe = 'assets/images/items/battleRobe.svg';
  static const woodenShield = 'assets/images/items/woodenShield.svg';
  static const spikyShield = 'assets/images/items/spikyShield.svg';
  static const magicShield = 'assets/images/items/magicShield.svg';
  static const heavyShield = 'assets/images/items/heavyShield.svg';
  static const protectiveCharm = 'assets/images/items/protectiveCharm.svg';
  static const dreamCatcher = 'assets/images/items/dreamCatcher.svg';

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

  //VALUABLES
  static const gold = 'assets/images/items/gold.svg';

  String getItemIcon(String item) {
    String itemIcon = '';

    switch (item) {
      case 'empty':
        itemIcon = punch;
        break;

      //VALUABLES
      case 'gold':
        itemIcon = gold;
        break;

      //LIGHT WEAPONS
      case 'batton':
        itemIcon = batton;
        break;
      case 'dagger':
        itemIcon = dagger;
        break;
      case 'flail':
        itemIcon = flail;
        break;
      case 'gladius':
        itemIcon = gladius;
        break;
      case 'mace':
        itemIcon = mace;
        break;
      case 'morning star':
        itemIcon = morningStar;
        break;
      case 'nunchaku':
        itemIcon = nunchaku;
        break;
      case 'poison dagger':
        itemIcon = poisonDagger;
        break;
      case 'rapier':
        itemIcon = rapier;
        break;
      case 'saber':
        itemIcon = saber;
        break;
      case 'sharp fist':
        itemIcon = sharpFist;
        break;
      case 'short spear':
        itemIcon = shortSpear;
        break;
      case 'short sword':
        itemIcon = shortSword;
        break;
      case 'talon':
        itemIcon = talon;
        break;
      case 'wood axe':
        itemIcon = woodAxe;
        break;

      //HEAVY WEAPONS
      case 'giant club':
        itemIcon = giantClub;
        break;
      case 'war hammer':
        itemIcon = warHammer;
        break;
      case 'katana':
        itemIcon = katana;
        break;
      case 'long sword':
        itemIcon = longSword;
        break;
      case 'battle axe':
        itemIcon = battleAxe;
        break;
      case 'double sword':
        itemIcon = doubleSword;
        break;
      case 'quarterstaff':
        itemIcon = quarterstaff;
        break;
      case 'trident':
        itemIcon = trident;
        break;
      case 'long spear':
        itemIcon = longSpear;
        break;
      case 'great sword':
        itemIcon = greatSword;
        break;
      case 'halberd':
        itemIcon = halberd;
        break;
      case 'long axe':
        itemIcon = longAxe;
        break;
      case 'whip':
        itemIcon = whip;
        break;

      //RANGED WEAPONS
      case 'boomerang':
        itemIcon = boomerang;
        break;
      case 'composite bow':
        itemIcon = compositeBow;
        break;
      case 'hand cannon':
        itemIcon = handCannon;
        break;
      case 'hand crossbow':
        itemIcon = handCrossbow;
        break;
      case 'heavy crossbow':
        itemIcon = heavyCrossbow;
        break;
      case 'javelins':
        itemIcon = javelins;
        break;
      case 'kunai':
        itemIcon = kunai;
        break;
      case 'light crossbow':
        itemIcon = lightCrossbow;
        break;
      case 'long bow':
        itemIcon = longBow;
        break;
      case 'musket':
        itemIcon = musket;
        break;
      case 'poison dart':
        itemIcon = poisonDart;
        break;
      case 'short bow':
        itemIcon = shortBow;
        break;

      //ARMOR
      case 'straw hat':
        itemIcon = strawHat;
        break;
      case 'helmet':
        itemIcon = helmet;
        break;
      case 'hood':
        itemIcon = hood;
        break;
      case 'full helmet':
        itemIcon = fullHemlet;
        break;
      case 'short gloves':
        itemIcon = shortGloves;
        break;
      case 'leather gloves':
        itemIcon = leatherGloves;
        break;
      case 'gauntlet':
        itemIcon = gauntlet;
        break;
      case 'spiky gauntlet':
        itemIcon = spikyGauntlet;
        break;
      case 'boots':
        itemIcon = boots;
        break;
      case 'heavy boots':
        itemIcon = heavyBoots;
        break;
      case 'sandals':
        itemIcon = sandals;
        break;
      case 'shoes':
        itemIcon = shoes;
        break;
      case 'light armor':
        itemIcon = lightArmor;
        break;
      case 'heavy armor':
        itemIcon = heavyArmor;
        break;
      case 'robe':
        itemIcon = robe;
        break;
      case 'battle robe':
        itemIcon = battleRobe;
        break;
      case 'wooden shield':
        itemIcon = woodenShield;
        break;
      case 'spiky shield':
        itemIcon = spikyShield;
        break;
      case 'magic shield':
        itemIcon = magicShield;
        break;
      case 'heavy shield':
        itemIcon = heavyShield;
        break;
      case 'protective charm':
        itemIcon = protectiveCharm;
        break;
      case 'dream catcher':
        itemIcon = dreamCatcher;
        break;
    }

    return itemIcon;
  }

  //ACTIONS
  static const actionBite = 'assets/images/ui/actionBite.svg';
  static const actionBlast = 'assets/images/ui/actionBlast.svg';
  static const actionClaw = 'assets/images/ui/actionClaw.svg';
  static const actionCrush = 'assets/images/ui/actionCrush.svg';
  static const actionDefend = 'assets/images/ui/actionDefend.svg';
  static const actionJab = 'assets/images/ui/actionJab.svg';
  static const actionLook = 'assets/images/ui/actionLook.svg';
  static const actionReload = 'assets/images/ui/actionReload.svg';
  static const actionShot = 'assets/images/ui/actionShot.svg';
  static const actionSlam = 'assets/images/ui/actionSlam.svg';
  static const actionSlash = 'assets/images/ui/actionSwing.svg';
  static const actionSwing = 'assets/images/ui/actionSwing.svg';
  static const actionThrow = 'assets/images/ui/actionThrow.svg';
  static const actionThrust = 'assets/images/ui/actionThrust.svg';
  static const actionTongue = 'assets/images/ui/actionTongue.svg';
  static const actionVolley = 'assets/images/ui/actionVolley.svg';
  static const actionWhip = 'assets/images/ui/actionWhip.svg';

  String getActionIcon(String action) {
    String actionIcon = actionJab;

    switch (action) {
      case 'bite':
        actionIcon = actionBite;
        break;
      case 'blast':
        actionIcon = actionBlast;
        break;
      case 'claw':
        actionIcon = actionClaw;
        break;
      case 'crush':
        actionIcon = actionCrush;
        break;
      case 'defend':
        actionIcon = actionDefend;
        break;
      case 'jab':
        actionIcon = actionJab;
        break;
      case 'look':
        actionIcon = actionLook;
        break;
      case 'reload':
        actionIcon = actionReload;
        break;
      case 'shot':
        actionIcon = actionShot;
        break;
      case 'slam':
        actionIcon = actionSlam;
        break;
      case 'slash':
        actionIcon = actionSlash;
        break;
      case 'swing':
        actionIcon = actionSwing;
        break;
      case 'throw':
        actionIcon = actionThrow;
        break;
      case 'thrust':
        actionIcon = actionThrust;
        break;
      case 'tongue':
        actionIcon = actionTongue;
        break;
      case 'volley':
        actionIcon = actionVolley;
        break;
      case 'whip':
        actionIcon = actionWhip;
        break;
    }

    return actionIcon;
  }

  //Sprites
  //PROPS
  static const grave = 'assets/images/sprites/props/grave.svg';
  static const graveColor = 'assets/images/sprites/props/graveColor.svg';

  static const normalChestClosed =
      'assets/images/sprites/props/normalChestClosed.svg';
  static const normalChestOpen =
      'assets/images/sprites/props/normalChestOpen.svg';
  static const magicChestClosed =
      'assets/images/sprites/props/magicChestClosed.svg';
  static const magicChestOpen =
      'assets/images/sprites/props/magicChestOpen.svg';

  String getPropSprite(String prop, bool open) {
    String propSprite = '';

    switch (prop) {
      case 'normal chest':
        if (open) {
          propSprite = normalChestOpen;
        } else {
          propSprite = normalChestClosed;
        }

        break;
      case 'magic chest':
        if (open) {
          propSprite = magicChestOpen;
        } else {
          propSprite = magicChestClosed;
        }
        break;
    }

    return propSprite;
  }

  //PLAYERS
  //DWARF
  static const maleDwarfBody =
      'assets/images/sprites/players/maleDwarfBody.svg';
  static const maleDwarfHead =
      'assets/images/sprites/players/maleDwarfHead.svg';
  static const femaleDwarfBody =
      'assets/images/sprites/players/femaleDwarfBody.svg';
  static const femaleDwarfHead =
      'assets/images/sprites/players/femaleDwarfHead.svg';

  //ORC
  static const maleOrcBody = 'assets/images/sprites/players/maleOrcBody.svg';
  static const maleOrcHead = 'assets/images/sprites/players/maleOrcHead.svg';
  static const femaleOrcBody =
      'assets/images/sprites/players/femaleOrcBody.svg';
  static const femaleOrcHead =
      'assets/images/sprites/players/femaleOrcHead.svg';

  //ELF
  static const maleElfBody = 'assets/images/sprites/players/maleElfBody.svg';
  static const maleElfHead = 'assets/images/sprites/players/maleElfHead.svg';
  static const femaleElfBody =
      'assets/images/sprites/players/femaleElfBody.svg';
  static const femaleElfHead =
      'assets/images/sprites/players/femaleElfHead.svg';

  String getPlayerBodySprite(String race, String sex) {
    String selectedSprite = '';

    switch (race) {
      case 'dwarf':
        if (sex == 'female') {
          selectedSprite = AppImages.femaleDwarfBody;
        } else {
          selectedSprite = AppImages.maleDwarfBody;
        }
        break;

      case 'orc':
        if (sex == 'female') {
          selectedSprite = AppImages.femaleOrcBody;
        } else {
          selectedSprite = AppImages.maleOrcBody;
        }
        break;

      case 'elf':
        if (sex == 'female') {
          selectedSprite = AppImages.femaleElfBody;
        } else {
          selectedSprite = AppImages.maleElfBody;
        }
    }

    return selectedSprite;
  }

  String getPlayerHeadSprite(String race, String sex) {
    String selectedSprite = '';

    switch (race) {
      case 'dwarf':
        if (sex == 'female') {
          selectedSprite = AppImages.femaleDwarfHead;
        } else {
          selectedSprite = AppImages.maleDwarfHead;
        }
        break;

      case 'orc':
        if (sex == 'female') {
          selectedSprite = AppImages.femaleOrcHead;
        } else {
          selectedSprite = AppImages.maleOrcHead;
        }
        break;

      case 'elf':
        if (sex == 'female') {
          selectedSprite = AppImages.femaleElfHead;
        } else {
          selectedSprite = AppImages.maleElfHead;
        }
    }

    return selectedSprite;
  }

  //NPCS
  static const zombieSprite = 'assets/images/sprites/npcs/zombie.svg';
  static const giantBatSprite = 'assets/images/sprites/npcs/giantBat.svg';
  static const skeletonSprite = 'assets/images/sprites/npcs/skeleton.svg';
  static const skeletonMageSprite =
      'assets/images/sprites/npcs/skeletonMage.svg';
  static const giantFrogSprite = 'assets/images/sprites/npcs/giantFrog.svg';
  static const goblinSprite = 'assets/images/sprites/npcs/goblin.svg';
  static const basiliskSprite = 'assets/images/sprites/npcs/basilisk.svg';

  String getNpcSprite(String npc) {
    String npcSprite = '';

    switch (npc) {
      case 'zombie':
        npcSprite = zombieSprite;
        break;
      case 'giant bat':
        npcSprite = giantBatSprite;
        break;
      case 'skeleton':
        npcSprite = skeletonSprite;
        break;
      case 'skeleton mage':
        npcSprite = skeletonMageSprite;
        break;
      case 'giant frog':
        npcSprite = giantFrogSprite;
        break;
      case 'goblin':
        npcSprite = goblinSprite;
        break;
      case 'basilisk':
        npcSprite = basiliskSprite;
        break;
    }

    return npcSprite;
  }

  //BUILDINGS
  static const blackTablet = 'assets/images/sprites/buildings/blackTablet.svg';
  static const divineAltar = 'assets/images/sprites/buildings/divineAltar.svg';
  static const earthAltar = 'assets/images/sprites/buildings/earthAltar.svg';
  static const sacrificeAltar =
      'assets/images/sprites/buildings/sacrificeAltar.svg';
  static const tower = 'assets/images/sprites/buildings/tower.svg';
  static const barricade = 'assets/images/sprites/buildings/barricade.svg';

  String getBuildingSprite(String building) {
    String buildingSprite = '';

    switch (building) {
      case 'black tablet':
        buildingSprite = blackTablet;
        break;
      case 'divine altar':
        buildingSprite = divineAltar;
        break;
      case 'earth altar':
        buildingSprite = earthAltar;
        break;
      case 'sacrifice altar':
        buildingSprite = sacrificeAltar;
        break;
      case 'tower':
        buildingSprite = tower;
        break;

      case 'barricade':
        buildingSprite = barricade;
        break;
    }

    return buildingSprite;
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
