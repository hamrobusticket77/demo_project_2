import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:krishi_hub/feature/weather/model/main_model.dart';
import 'package:krishi_hub/feature/weather/model/today_weather_model.dart';
import 'package:krishi_hub/feature/weather/model/weaher_model.dart';

class FiveDaysWeatherModel {
  final String dt_txt;
  List<WeatherModel> weather;
  final Main main;
  FiveDaysWeatherModel({
    required this.dt_txt,
    required this.weather,
    required this.main,
  });

  factory FiveDaysWeatherModel.fromMap(Map<String, dynamic> map) {
    return FiveDaysWeatherModel(
      dt_txt: map['dt_txt'] as String,
      weather: (map['weather'] as List<dynamic>)
          .map<WeatherModel>((x) => WeatherModel.fromMap(x ?? {}))
          .toList(),
      main: Main.fromMap(map['main'] as Map<String, dynamic>),
    );
  }

  factory FiveDaysWeatherModel.fromJson(String source) =>
      FiveDaysWeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  FiveDaysWeatherModel copyWith({
    String? dt_txt,
    List<WeatherModel>? weather,
    Wind? wind,
  }) {
    return FiveDaysWeatherModel(
      dt_txt: dt_txt ?? this.dt_txt,
      weather: weather ?? this.weather,
      main: main ?? main,
    );
  }

  @override
  String toString() =>
      'FiveDaysWeatherModel(dt_txt: $dt_txt, weather: $weather, wind: $main)';

  @override
  bool operator ==(covariant FiveDaysWeatherModel other) {
    if (identical(this, other)) return true;

    return other.dt_txt == dt_txt &&
        listEquals(other.weather, weather) &&
        other.main == main;
  }

  @override
  int get hashCode => dt_txt.hashCode ^ weather.hashCode ^ main.hashCode;
}
