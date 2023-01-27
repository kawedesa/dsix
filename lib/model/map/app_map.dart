class AppMap {
  String name;
  String map;
  AppMap({
    required this.name,
    required this.map,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'map': map,
    };
  }

  factory AppMap.fromMap(Map<String, dynamic>? data) {
    return AppMap(
      name: data?['name'],
      map: data?['map'],
    );
  }

  factory AppMap.empty() {
    return AppMap(
      name: '',
      map: '',
    );
  }
}
