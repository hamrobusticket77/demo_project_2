import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/slider/model/slider_model.dart';
import 'package:krishi_hub/feature/slider/resource/slider_repository.dart';

import '../../../common/cubit/data_state.dart';
import '../../../common/response/response.dart';

class GetSliderCubit extends Cubit<CommonState> {
  final SliderRepository sliderRepository;
  GetSliderCubit({required this.sliderRepository}) : super(CommonInitial());

  getSlider() async {
    emit(CommonLoading());
    // await Future.delayed(const Duration(milliseconds: 200));
    final res = await sliderRepository.getslider();
    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<SliderModel>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }

  reloadSlider() async {
    emit(CommonDummyLoading());

    // await Future.delayed(const Duration(milliseconds: 200));
    final res = await sliderRepository.getslider();
    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<SliderModel>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }
}
