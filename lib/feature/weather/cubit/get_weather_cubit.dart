import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/weather/model/today_weather_model.dart';
import 'package:krishi_hub/feature/weather/resources/weather_repository.dart';

class GetWeatherCubit extends Cubit<CommonState> {
  final WeatherRepository weatherRepository;
  GetWeatherCubit({required this.weatherRepository}) : super(CommonInitial());

  getWeather({String? cityName}) async {
    emit(CommonLoading());
    // await Future.delayed(const Duration(milliseconds: 200));
    final res = await weatherRepository.getWeather(cityname: cityName);
    if (res.status == Status.success) {
      if (res.data != null) {
        emit(CommonStateSuccess<TodayWeatherModel>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }
}
