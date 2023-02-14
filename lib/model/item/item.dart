class Item {
  String name;
  String description;
  String itemSlot;
  String type;
  int pDamage;
  int mDamage;
  int pArmor;
  int mArmor;
  int weight;
  int value;
  double maxRange;
  double minRange;
  String attackType;
  Item({
    required this.name,
    required this.description,
    required this.itemSlot,
    required this.type,
    required this.pDamage,
    required this.mDamage,
    required this.pArmor,
    required this.mArmor,
    required this.weight,
    required this.value,
    required this.maxRange,
    required this.minRange,
    required this.attackType,
  });

  factory Item.fromMap(Map<String, dynamic>? data) {
    return Item(
      name: data?['name'],
      description: data?['description'],
      itemSlot: data?['itemSlot'],
      type: data?['type'],
      pDamage: data?['pDamage'],
      mDamage: data?['mDamage'],
      pArmor: data?['pArmor'],
      mArmor: data?['mArmor'],
      weight: data?['weight'],
      value: data?['value'],
      maxRange: data?['maxRange'] * 1.0,
      minRange: data?['minRange'] * 1.0,
      attackType: data?['attackType'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'itemSlot': itemSlot,
      'type': type,
      'pDamage': pDamage,
      'mDamage': mDamage,
      'pArmor': pArmor,
      'mArmor': mArmor,
      'weight': weight,
      'value': value,
      'maxRange': maxRange,
      'minRange': minRange,
      'attackType': attackType,
    };
  }

  factory Item.empty() {
    return Item(
      name: 'fist',
      description: '',
      itemSlot: '',
      type: '',
      pDamage: 0,
      mDamage: 0,
      pArmor: 0,
      mArmor: 0,
      weight: 0,
      value: 0,
      maxRange: 10,
      minRange: 0,
      attackType: 'rectangle',
    );
  }
}
