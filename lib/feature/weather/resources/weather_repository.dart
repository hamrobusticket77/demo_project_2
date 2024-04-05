import 'package:flutter/material.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/feature/weather/model/today_weather_model.dart';
import 'package:krishi_hub/feature/weather/model/five_days_weather.dart';
import 'package:krishi_hub/feature/weather/resources/weather_api_provider.dart';
import 'package:krishi_hub/http/api_provider.dart';
import 'package:krishi_hub/common/response/response.dart';

class WeatherRepository {
  final Env env;
  final ApiProvider apiProvider;
  late WeatherApiProvider weatherApiProvider;
  WeatherRepository({
    required this.apiProvider,
    required this.env,
  }) {
    weatherApiProvider = WeatherApiProvider(
      apiProvider: apiProvider,
      weatherApiKey: env.weatherApiKey,
    );
  }
  String _lat = '';
  String _long = '';
  final List<String> _items = [];
  List<String> get getItems => _items;

  Future<DataResponse<TodayWeatherModel>> getWeather({
    String? cityname,
  }) async {
    try {
      final latlong = await weatherApiProvider.getWeatherCityWise(
        city: cityname,
      );

      final data = latlong['data']?['data'] ?? [];
      if (data.isNotEmpty) {
        _lat = data[0]?['lat']?.toString() ?? "0";
        _long = data[0]?["lon"]?.toString() ?? "0";
      }
      final res = await weatherApiProvider.getWeather(
        lat: _lat,
        long: _long,
      );
      TodayWeatherModel temp = TodayWeatherModel.fromMap(res['data'] ?? {});

      return DataResponse.success(temp);
    } catch (e) {
      debugPrint(e.toString());

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<FiveDaysWeatherModel>>> getFiveDaysWeather({
    String? cityName,
  }) async {
    try {
      final res = await weatherApiProvider.getTomorrowWeather(
        lat: _lat,
        long: _long,
      );

      List<FiveDaysWeatherModel> temp = [];

      temp = List.from(res['data']?["list"] ?? [])
          .map((e) => FiveDaysWeatherModel.fromMap(e))
          .toList();
      // List<FiveDaysWeatherModel> filteredData = temp.where((weatherData) {
      //   DateTime dtTxt = DateTime.parse(weatherData.dt_txt);
      //   return (dtTxt.hour == 0 &&
      //       dtTxt.minute == 0 &&
      //       dtTxt.isAfter(DateTime.now()) &&
      //       dtTxt.isBefore(
      //         DateTime.now().add(const Duration(days: 5)),
      //       ));
      // }).toList();

      return DataResponse.success(temp);
    } catch (e) {
      debugPrint(e.toString());
      return DataResponse.error(e.toString());
    }
  }
}
