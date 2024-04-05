import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/weather/model/five_days_weather.dart';
import 'package:krishi_hub/feature/weather/resources/weather_repository.dart';

class GetFiveDaysWeatherCubit extends Cubit<CommonState> {
  final WeatherRepository weatherRepository;
  GetFiveDaysWeatherCubit({required this.weatherRepository})
      : super(CommonInitial());

  getTomorrowWeather({String? cityName}) async {
    emit(CommonLoading());
    // await Future.delayed(const Duration(milliseconds: 200));
    final res = await weatherRepository.getFiveDaysWeather(cityName: cityName);
    if (res.status == Status.success) {
      if (res.data != null) {
        emit(CommonDataFetchSuccess<FiveDaysWeatherModel>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }
}
