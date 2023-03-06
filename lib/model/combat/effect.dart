class Effect {
  String name;
  String type;
  String description;
  int value;
  int countdown;

  Effect(
      {required this.name,
      required this.type,
      required this.description,
      required this.value,
      required this.countdown});

  factory Effect.empty() {
    return Effect(
      name: '',
      type: '',
      description: '',
      value: 0,
      countdown: 0,
    );
  }

  factory Effect.fromMap(Map<String, dynamic>? data) {
    return Effect(
      name: data?['name'],
      type: data?['type'],
      description: data?['description'],
      value: data?['value'],
      countdown: data?['countdown'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'description': description,
      'value': value,
      'countdown': countdown,
    };
  }
}
