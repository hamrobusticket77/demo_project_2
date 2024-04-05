import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/weather/cubit/get_weather_cubit.dart';
import 'package:krishi_hub/feature/weather/ui/widget/weather_widget.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(
        weatherRepository: RepositoryProvider.of(context),
      )..getWeather(),
      child: const WeatherWidgetPage(),
    );
  }
}
