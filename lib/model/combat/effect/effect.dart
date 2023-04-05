class Effect {
  String name;
  String description;
  int value;
  int countdown;

  Effect(
      {required this.name,
      required this.description,
      required this.value,
      required this.countdown});

  factory Effect.empty() {
    return Effect(
      name: '',
      description: '',
      value: 0,
      countdown: 0,
    );
  }

  factory Effect.fromMap(Map<String, dynamic>? data) {
    return Effect(
      name: data?['name'],
      description: data?['description'],
      value: data?['value'],
      countdown: data?['countdown'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'value': value,
      'countdown': countdown,
    };
  }

  void decreaseCountdown() {
    countdown--;
  }

  void increaseCountdown() {
    countdown++;
  }

  void reset() {
    countdown = 0;
  }
}
