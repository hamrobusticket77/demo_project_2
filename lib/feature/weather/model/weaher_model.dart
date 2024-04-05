class WeatherModel {
  final int id;
  final String main;
  final String description;
  final String icon;
  WeatherModel({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      id: (map['id'] as int?) ?? 1,
      main: map['main'] ?? '',
      description: map['description'] ?? '',
      icon: map['icon'] ?? '',
    );
  }

  // String toJson() => json.encode(toMap());

  // factory WeatherModel.fromJson(String source) =>
  //     WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  WeatherModel copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) {
    return WeatherModel(
      id: id ?? this.id,
      main: main ?? this.main,
      description: description ?? this.description,
      icon: icon ?? this.icon,
    );
  }

  @override
  String toString() {
    return 'WeatherModel(id: $id, main: $main, description: $description, icon: $icon)';
  }

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.main == main &&
        other.description == description &&
        other.icon == icon;
  }

  @override
  int get hashCode {
    return id.hashCode ^ main.hashCode ^ description.hashCode ^ icon.hashCode;
  }
}
