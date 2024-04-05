import '../../../http/api_provider.dart';

class WeatherApiProvider {
  final ApiProvider apiProvider;
  final String weatherApiKey;
  WeatherApiProvider({
    required this.apiProvider,
    required this.weatherApiKey,
  });
  final String _weatherBaseUrl = "https://api.openweathermap.org/data";

  Future<dynamic> getWeather({
    String lat = "",
    String long = "",
  }) async {
    Uri uri = Uri.parse(
        "$_weatherBaseUrl/2.5/weather?lat=$lat&lon=$long&appid=$weatherApiKey");
    return await apiProvider.get(
      uri,
    );
  }

  Future<dynamic> getTomorrowWeather(
      {String lat = "", String long = ""}) async {
    Uri uri = Uri.parse(
        "$_weatherBaseUrl/2.5/forecast?lat=$lat&lon=$long&appid=$weatherApiKey");
    return await apiProvider.get(
      uri,
    );
  }

  Future<dynamic> getWeatherCityWise({required String? city}) async {
    Uri uri = Uri.parse(
        "https://api.openweathermap.org/geo/1.0/direct?q=${city ?? "Kathmandu"}&limit=5&appid=$weatherApiKey");

    return await apiProvider.get(uri);
  }
}
