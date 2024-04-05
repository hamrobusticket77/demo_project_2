import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/weather/cubit/get_five_days_weather_cubit.dart';
import 'package:krishi_hub/feature/weather/ui/widget/five_days_weather_widget.dart';

class FiveDaysWeatherPage extends StatelessWidget {
  const FiveDaysWeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetFiveDaysWeatherCubit(
        weatherRepository: RepositoryProvider.of(context),
      )..getTomorrowWeather(),
      child: const FiveDaysWeatherWidget(),
    );
  }
}
