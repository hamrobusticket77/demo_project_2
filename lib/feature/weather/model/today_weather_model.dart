import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:krishi_hub/feature/weather/model/main_model.dart';

import 'package:krishi_hub/feature/weather/model/weaher_model.dart';

class TodayWeatherModel {
  final Coord coord;
  final String base;
  final Main main;
  final int visibility;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  List<WeatherModel> weather;
  final int id;
  final String name;
  final int cod;
  TodayWeatherModel({
    required this.coord,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.weather,
    required this.id,
    required this.name,
    required this.cod,
  });



  factory TodayWeatherModel.fromMap(Map<String, dynamic> map) {
    return TodayWeatherModel(
      coord: Coord.fromMap(map['coord'] ?? {}),
      base: map['base'] ?? '',
      main: Main.fromMap(map['main'] ?? {}),
      visibility: map['visibility'] as int,
      wind: Wind.fromMap(map['wind'] ?? {}),
      clouds: Clouds.fromMap(map['clouds'] ?? {}),
      dt: map['dt'] as int,
      sys: Sys.fromMap(map['sys'] ?? {}),
      timezone: map['timezone'] as int,
      weather: (map['weather'] as List<dynamic>)
          .map<WeatherModel>((x) => WeatherModel.fromMap(x ?? {}))
          .toList(),
      id: map['id'] as int,
      name: map['name'] ?? '',
      cod: map['cod'] as int,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory TodayWeaherModel.fromJson(String source) =>
  //     TodayWeaherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TodayWeatherModel copyWith({
    Coord? coord,
    String? base,
    Main? main,
    int? visibility,
    Wind? wind,
    Clouds? clouds,
    int? dt,
    Sys? sys,
    int? timezone,
    List<WeatherModel>? weatherodel,
    int? id,
    String? name,
    int? cod,
  }) {
    return TodayWeatherModel(
      coord: coord ?? this.coord,
      base: base ?? this.base,
      main: main ?? this.main,
      visibility: visibility ?? this.visibility,
      wind: wind ?? this.wind,
      clouds: clouds ?? this.clouds,
      dt: dt ?? this.dt,
      sys: sys ?? this.sys,
      timezone: timezone ?? this.timezone,
      weather: weatherodel ?? weather,
      id: id ?? this.id,
      name: name ?? this.name,
      cod: cod ?? this.cod,
    );
  }

  @override
  String toString() {
    return 'TodayWeaherModel(coord: $coord, base: $base, main: $main, visibility: $visibility, wind: $wind, clouds: $clouds, dt: $dt, sys: $sys, timezone: $timezone, weatherodel: $weather, id: $id, name: $name, cod: $cod)';
  }

  @override
  bool operator ==(covariant TodayWeatherModel other) {
    if (identical(this, other)) return true;

    return other.coord == coord &&
        other.base == base &&
        other.main == main &&
        other.visibility == visibility &&
        other.wind == wind &&
        other.clouds == clouds &&
        other.dt == dt &&
        other.sys == sys &&
        other.timezone == timezone &&
        listEquals(other.weather, weather) &&
        other.id == id &&
        other.name == name &&
        other.cod == cod;
  }

  @override
  int get hashCode {
    return coord.hashCode ^
        base.hashCode ^
        main.hashCode ^
        visibility.hashCode ^
        wind.hashCode ^
        clouds.hashCode ^
        dt.hashCode ^
        sys.hashCode ^
        timezone.hashCode ^
        weather.hashCode ^
        id.hashCode ^
        name.hashCode ^
        cod.hashCode;
  }
}

class Coord {
  final double lon;
  final double lat;
  Coord({
    required this.lon,
    required this.lat,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lon': lon,
      'lat': lat,
    };
  }

  factory Coord.fromMap(Map<String, dynamic> map) {
    return Coord(
      lon: (map['lon'] as double?) ?? 0.0,
      lat: (map['lat'] as double?) ?? 0.0,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Coord.fromJson(String source) =>
  //     Coord.fromMap(json.decode(source) as Map<String, dynamic>);

  Coord copyWith({
    double? lon,
    double? lat,
  }) {
    return Coord(
      lon: lon ?? this.lon,
      lat: lat ?? this.lat,
    );
  }

  @override
  String toString() => 'Coord(lon: $lon, lat: $lat)';

  @override
  bool operator ==(covariant Coord other) {
    if (identical(this, other)) return true;

    return other.lon == lon && other.lat == lat;
  }

  @override
  int get hashCode => lon.hashCode ^ lat.hashCode;
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;
  Weather({
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

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      id: map['id'] as int,
      main: map['main'] as String,
      description: map['description'] as String,
      icon: map['icon'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) =>
      Weather.fromMap(json.decode(source) as Map<String, dynamic>);

  Weather copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) {
    return Weather(
      id: id ?? this.id,
      main: main ?? this.main,
      description: description ?? this.description,
      icon: icon ?? this.icon,
    );
  }

  @override
  String toString() {
    return 'Weather(id: $id, main: $main, description: $description, icon: $icon)';
  }

  @override
  bool operator ==(covariant Weather other) {
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



class Wind {
  final double speed;
  final int deg;
  Wind({
    required this.speed,
    required this.deg,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'speed': speed,
      'deg': deg,
    };
  }

  factory Wind.fromMap(Map<String, dynamic> map) {
    return Wind(
      // speed: map['speed'] as double,
      speed: double.parse(map['speed'].toString()),
      deg: map['deg'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Wind.fromJson(String source) =>
      Wind.fromMap(json.decode(source) as Map<String, dynamic>);

  Wind copyWith({
    double? speed,
    int? deg,
  }) {
    return Wind(
      speed: speed ?? this.speed,
      deg: deg ?? this.deg,
    );
  }

  @override
  String toString() => 'Wind(speed: $speed, deg: $deg)';

  @override
  bool operator ==(covariant Wind other) {
    if (identical(this, other)) return true;

    return other.speed == speed && other.deg == deg;
  }

  @override
  int get hashCode => speed.hashCode ^ deg.hashCode;
}

class Clouds {
  final int all;
  Clouds({
    required this.all,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'all': all,
    };
  }

  factory Clouds.fromMap(Map<String, dynamic> map) {
    return Clouds(
      all: map['all'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Clouds.fromJson(String source) =>
      Clouds.fromMap(json.decode(source) as Map<String, dynamic>);

  Clouds copyWith({
    int? all,
  }) {
    return Clouds(
      all: all ?? this.all,
    );
  }

  @override
  String toString() => 'Clouds(all: $all)';

  @override
  bool operator ==(covariant Clouds other) {
    if (identical(this, other)) return true;

    return other.all == all;
  }

  @override
  int get hashCode => all.hashCode;
}

class Sys {
  // final int type;
  // final int id;
  final String country;
  final int sunrise;
  final int sunset;
  Sys({
    // required this.type,
    // required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'type': type,
      // 'id': id,
      'country': country,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }

  factory Sys.fromMap(Map<String, dynamic> map) {
    return Sys(
      // type: map['type'] as int,
      // id: map['id'] as int,
      country: map['country'] as String,
      sunrise: map['sunrise'] as int,
      sunset: map['sunset'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Sys.fromJson(String source) =>
      Sys.fromMap(json.decode(source) as Map<String, dynamic>);

  Sys copyWith({
    int? type,
    int? id,
    String? country,
    int? sunrise,
    int? sunset,
  }) {
    return Sys(
      // type: type ?? this.type,
      // id: id ?? this.id,
      country: country ?? this.country,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
    );
  }

  @override
  String toString() {
    return 'Sys( country: $country, sunrise: $sunrise, sunset: $sunset)';
  }

  @override
  bool operator ==(covariant Sys other) {
    if (identical(this, other)) return true;

    return other.country == country &&
        other.sunrise == sunrise &&
        other.sunset == sunset;
  }

  @override
  int get hashCode {
    return country.hashCode ^ sunrise.hashCode ^ sunset.hashCode;
  }
}
