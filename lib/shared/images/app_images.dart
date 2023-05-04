class AppImages {
  //UI
  static const logo = 'assets/images/ui/logo.svg';
  static const cancel = 'assets/images/ui/cancel.svg';
  static const duplicate = 'assets/images/ui/duplicate.svg';
  static const horizontalFlip = 'assets/images/ui/horizontalFlip.svg';
  static const verticalFlip = 'assets/images/ui/verticalFlip.svg';
  static const rotationRight = 'assets/images/ui/rotationRight.svg';
  static const rotationLeft = 'assets/images/ui/rotationLeft.svg';
  static const confirm = 'assets/images/ui/confirm.svg';
  static const left = 'assets/images/ui/left.svg';
  static const right = 'assets/images/ui/right.svg';
  static const top = 'assets/images/ui/top.svg';
  static const bottom = 'assets/images/ui/bottom.svg';
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
  static const effectPoison = 'assets/images/ui/effectPoison.svg';
  static const effectBleed = 'assets/images/ui/effectBleed.svg';
  static const effectBlind = 'assets/images/ui/effectBlind.svg';
  static const effectBurn = 'assets/images/ui/effectBurn.svg';
  static const effectCry = 'assets/images/ui/effectCry.svg';
  static const effectEmpower = 'assets/images/ui/effectEmpower.svg';
  static const effectIllusion = 'assets/images/ui/effectIllusion.svg';
  static const effectRage = 'assets/images/ui/effectRage.svg';
  static const effectSlow = 'assets/images/ui/effectSlow.svg';
  static const effectStun = 'assets/images/ui/effectStun.svg';
  static const effectTempVision = 'assets/images/ui/effectTempVision.svg';
  static const effectTempArmor = 'assets/images/ui/effectTempArmor.svg';
  static const effectVulnerable = 'assets/images/ui/effectVulnerable.svg';
  static const effectWeaken = 'assets/images/ui/effectWeaken.svg';

  String getEffectIcon(String effect) {
    String effectIcon = '';

    switch (effect) {
      case 'bleed':
        effectIcon = effectBleed;
        break;
      case 'blind':
        effectIcon = effectBlind;
        break;
      case 'burn':
        effectIcon = effectBurn;
        break;
      case 'cry':
        effectIcon = effectCry;
        break;
      case 'empower':
        effectIcon = effectEmpower;
        break;
      case 'illusion':
        effectIcon = effectIllusion;
        break;
      case 'rage':
        effectIcon = effectRage;
        break;
      case 'poison':
        effectIcon = effectPoison;
        break;
      case 'slow':
        effectIcon = effectSlow;
        break;
      case 'stun':
        effectIcon = effectStun;
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
      case 'weaken':
        effectIcon = effectWeaken;
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
  static const chest = 'assets/images/ui/chest.svg';
  static const tile = 'assets/images/ui/tile.svg';
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

  //CONSUMABLES
  static const cleansingPotion = 'assets/images/items/cleansingPotion.svg';
  static const healingPotion = 'assets/images/items/healingPotion.svg';
  static const bandages = 'assets/images/items/bandages.svg';
  static const food = 'assets/images/items/food.svg';
  static const key = 'assets/images/items/key.svg';
  static const antidote = 'assets/images/items/antidote.svg';

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

      //CONSUMABLES
      case 'cleansing potion':
        itemIcon = cleansingPotion;
        break;
      case 'healing potion':
        itemIcon = healingPotion;
        break;
      case 'bandages':
        itemIcon = bandages;
        break;
      case 'food':
        itemIcon = food;
        break;
      case 'key':
        itemIcon = key;
        break;
      case 'antidote':
        itemIcon = antidote;
        break;
    }

    return itemIcon;
  }

  //ACTIONS
  static const actionBite = 'assets/images/ui/actionBite.svg';
  static const actionBlast = 'assets/images/ui/actionBlast.svg';
  static const actionBlind = 'assets/images/ui/actionBlind.svg';
  static const actionClaw = 'assets/images/ui/actionClaw.svg';
  static const actionCrush = 'assets/images/ui/actionCrush.svg';
  static const actionDefend = 'assets/images/ui/actionDefend.svg';
  static const actionEmpty = 'assets/images/ui/actionEmpty.svg';
  static const actionHide = 'assets/images/ui/actionHide.svg';
  static const actionJab = 'assets/images/ui/actionJab.svg';
  static const actionLook = 'assets/images/ui/actionLook.svg';
  static const actionMirrorImages = 'assets/images/ui/actionMirrorImages.svg';
  static const actionPunch = 'assets/images/ui/actionPunch.svg';
  static const actionReload = 'assets/images/ui/actionReload.svg';
  static const actionShot = 'assets/images/ui/actionShot.svg';
  static const actionSlam = 'assets/images/ui/actionSlam.svg';
  static const actionSlow = 'assets/images/ui/actionSlow.svg';
  static const actionSteal = 'assets/images/ui/actionSteal.svg';
  static const actionSlash = 'assets/images/ui/actionSwing.svg';
  static const actionSwing = 'assets/images/ui/actionSwing.svg';
  static const actionThrow = 'assets/images/ui/actionThrow.svg';
  static const actionThrust = 'assets/images/ui/actionThrust.svg';
  static const actionTongue = 'assets/images/ui/actionTongue.svg';
  static const actionVolley = 'assets/images/ui/actionVolley.svg';
  static const actionWhip = 'assets/images/ui/actionWhip.svg';

  String getActionIcon(String action) {
    String actionIcon = actionPunch;

    switch (action) {
      case '':
        actionIcon = actionJab;
        break;
      case 'bite':
        actionIcon = actionBite;
        break;
      case 'blast':
        actionIcon = actionBlast;
        break;
      case 'blind':
        actionIcon = actionBlind;
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
      case 'empty':
        actionIcon = actionEmpty;
        break;
      case 'hide':
        actionIcon = actionHide;
        break;
      case 'jab':
        actionIcon = actionJab;
        break;
      case 'look':
        actionIcon = actionLook;
        break;
      case 'mirror images':
        actionIcon = actionMirrorImages;
        break;
      case 'punch':
        actionIcon = actionPunch;
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
      case 'slow':
        actionIcon = actionSlow;
        break;
      case 'steal':
        actionIcon = actionSteal;
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
  static const grave = 'assets/images/sprites/chests/grave.svg';
  static const graveColor = 'assets/images/sprites/chests/graveColor.svg';

  static const normalChestClosed =
      'assets/images/sprites/chests/normalChestClosed.svg';
  static const normalChestOpen =
      'assets/images/sprites/chests/normalChestOpen.svg';
  static const magicChestClosed =
      'assets/images/sprites/chests/magicChestClosed.svg';
  static const magicChestOpen =
      'assets/images/sprites/chests/magicChestOpen.svg';

  String getChestSprite(String chest, bool open) {
    String chestSprite = '';

    switch (chest) {
      case 'normal chest':
        if (open) {
          chestSprite = normalChestOpen;
        } else {
          chestSprite = normalChestClosed;
        }

        break;
      case 'magic chest':
        if (open) {
          chestSprite = magicChestOpen;
        } else {
          chestSprite = magicChestClosed;
        }
        break;
    }

    return chestSprite;
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
  static const babyBear = 'assets/images/sprites/npcs/babyBear.svg';
  static const zombie = 'assets/images/sprites/npcs/zombie.svg';
  static const giantBat = 'assets/images/sprites/npcs/giantBat.svg';
  static const skeleton = 'assets/images/sprites/npcs/skeleton.svg';
  static const skeletonMage = 'assets/images/sprites/npcs/skeletonMage.svg';
  static const skeletonWarrior =
      'assets/images/sprites/npcs/skeletonWarrior.svg';
  static const demonHead = 'assets/images/sprites/npcs/demonHead.svg';
  static const giantFrog = 'assets/images/sprites/npcs/giantFrog.svg';
  static const goblinBandit = 'assets/images/sprites/npcs/goblinBandit.svg';
  static const goblinMarksman = 'assets/images/sprites/npcs/goblinMarksman.svg';
  static const basilisk = 'assets/images/sprites/npcs/basilisk.svg';
  static const mamaBear = 'assets/images/sprites/npcs/mamaBear.svg';
  static const gnomeWizzard = 'assets/images/sprites/npcs/gnomeWizzard.svg';

  String getNpcSprite(String npc) {
    String npcSprite = '';

    switch (npc) {
      case 'baby bear':
        npcSprite = babyBear;
        break;
      case 'zombie':
        npcSprite = zombie;
        break;
      case 'giant bat':
        npcSprite = giantBat;
        break;
      case 'skeleton':
        npcSprite = skeleton;
        break;
      case 'skeleton mage':
        npcSprite = skeletonMage;
        break;
      case 'skeleton warrior':
        npcSprite = skeletonWarrior;
        break;
      case 'demon head':
        npcSprite = demonHead;
        break;
      case 'giant frog':
        npcSprite = giantFrog;
        break;
      case 'goblin bandit':
        npcSprite = goblinBandit;
        break;
      case 'goblin marksman':
        npcSprite = goblinMarksman;
        break;
      case 'basilisk':
        npcSprite = basilisk;
        break;
      case 'mama bear':
        npcSprite = mamaBear;
        break;
      case 'gnome wizzard':
        npcSprite = gnomeWizzard;
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

  //TILE
  static const tile01 = 'assets/images/sprites/tiles/tile01.svg';
  static const tile02 = 'assets/images/sprites/tiles/tile02.svg';
  static const tile03 = 'assets/images/sprites/tiles/tile03.svg';
  static const tile04 = 'assets/images/sprites/tiles/tile04.svg';
  static const tile05 = 'assets/images/sprites/tiles/tile05.svg';
  static const tile06 = 'assets/images/sprites/tiles/tile06.svg';
  static const tile07 = 'assets/images/sprites/tiles/tile07.svg';
  static const tile08 = 'assets/images/sprites/tiles/tile08.svg';
  static const tile09 = 'assets/images/sprites/tiles/tile09.svg';
  static const tile10 = 'assets/images/sprites/tiles/tile10.svg';
  static const tile11 = 'assets/images/sprites/tiles/tile11.svg';
  static const tile12 = 'assets/images/sprites/tiles/tile12.svg';
  static const tile13 = 'assets/images/sprites/tiles/tile13.svg';
  static const tile14 = 'assets/images/sprites/tiles/tile14.svg';
  static const tile15 = 'assets/images/sprites/tiles/tile15.svg';
  static const tile16 = 'assets/images/sprites/tiles/tile16.svg';
  static const tile17 = 'assets/images/sprites/tiles/tile17.svg';
  static const tile18 = 'assets/images/sprites/tiles/tile18.svg';
  static const tile19 = 'assets/images/sprites/tiles/tile19.svg';
  static const tile20 = 'assets/images/sprites/tiles/tile20.svg';
  static const tile21 = 'assets/images/sprites/tiles/tile21.svg';
  static const tile22 = 'assets/images/sprites/tiles/tile22.svg';
  static const tile23 = 'assets/images/sprites/tiles/tile23.svg';
  static const tile24 = 'assets/images/sprites/tiles/tile24.svg';
  static const tile25 = 'assets/images/sprites/tiles/tile25.svg';
  static const tile26 = 'assets/images/sprites/tiles/tile26.svg';
  static const tile27 = 'assets/images/sprites/tiles/tile27.svg';
  static const tile28 = 'assets/images/sprites/tiles/tile28.svg';

  String getTileSprite(String tile) {
    String tileSprite = '';

    switch (tile) {
      case 'tile01':
        tileSprite = tile01;
        break;
      case 'tile02':
        tileSprite = tile02;
        break;
      case 'tile03':
        tileSprite = tile03;
        break;
      case 'tile04':
        tileSprite = tile04;
        break;
      case 'tile05':
        tileSprite = tile05;
        break;
      case 'tile06':
        tileSprite = tile06;
        break;
      case 'tile07':
        tileSprite = tile07;
        break;
      case 'tile08':
        tileSprite = tile08;
        break;
      case 'tile09':
        tileSprite = tile09;
        break;
      case 'tile10':
        tileSprite = tile10;
        break;
      case 'tile11':
        tileSprite = tile11;
        break;
      case 'tile12':
        tileSprite = tile12;
        break;
      case 'tile13':
        tileSprite = tile13;
        break;
      case 'tile14':
        tileSprite = tile14;
        break;
      case 'tile15':
        tileSprite = tile15;
        break;
      case 'tile16':
        tileSprite = tile16;
        break;
      case 'tile17':
        tileSprite = tile17;
        break;
      case 'tile18':
        tileSprite = tile18;
        break;
      case 'tile19':
        tileSprite = tile19;
        break;
      case 'tile20':
        tileSprite = tile20;
        break;
      case 'tile21':
        tileSprite = tile21;
        break;
      case 'tile22':
        tileSprite = tile22;
        break;
      case 'tile23':
        tileSprite = tile23;
        break;
      case 'tile24':
        tileSprite = tile24;
        break;
      case 'tile25':
        tileSprite = tile25;
        break;
      case 'tile26':
        tileSprite = tile26;
        break;
      case 'tile27':
        tileSprite = tile27;
        break;
      case 'tile28':
        tileSprite = tile28;
        break;
    }

    return tileSprite;
  }

  //Map
  static const emptyMap = 'assets/images/maps/emptyMap.svg';
  static const oldRuins = 'assets/images/maps/oldRuins.svg';
  static const crossroads = 'assets/images/maps/crossroads.svg';

  String getMapImage(String mapName) {
    String mapImage = '';

    switch (mapName) {
      case 'empty':
        mapImage = emptyMap;
        break;
      case 'old ruins':
        mapImage = oldRuins;
        break;
      case 'crossroads':
        mapImage = crossroads;
        break;
    }

    return mapImage;
  }
}
