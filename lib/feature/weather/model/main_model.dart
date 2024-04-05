class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final double pressure;
  final double seaLevel;
  final double grndLevel;
  final double humidity;
  final double tempKf;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory Main.fromMap(Map<String, dynamic> json) {
    return Main(
      temp: (json['temp'] != null) ? double.parse(json['temp'].toString()) : 0,
      feelsLike: (json['feels_like'] != null)
          ? double.parse(json['feels_like'].toString())
          : 0,
      tempMin: (json['temp_min'] != null)
          ? double.parse(json['temp_min'].toString())
          : 0,
      tempMax: (json['temp_max'] != null)
          ? double.parse(json['temp_max'].toString())
          : 0,
      pressure: (json['pressure'] != null)
          ? double.parse(json['pressure'].toString())
          : 0,
      seaLevel: (json['sea_level'] != null)
          ? double.parse(json['sea_level'].toString())
          : 0,
      grndLevel: (json['grnd_level'] != null)
          ? double.parse(json['grnd_level'].toString())
          : 0,
      humidity: (json['humidity'] != null)
          ? double.parse(json['humidity'].toString())
          : 0,
      tempKf: (json['temp_kf'] != null)
          ? double.parse(json['temp_kf'].toString())
          : 0,
    );
  }
}
