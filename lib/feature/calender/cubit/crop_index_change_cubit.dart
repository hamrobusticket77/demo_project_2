import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/feature/calender/resource/all_calender_repository.dart';
import 'package:krishi_hub/feature/calender/resource/calender_repository.dart';

class CropIndexChangeCubit extends Cubit<CommonState> {
  final CalenderRepository calenderRepository;

  final AllCalenderRepository allCalenderRepository;
  CropIndexChangeCubit({
    required this.calenderRepository,
    required this.allCalenderRepository,
  }) : super(CommonInitial());

  initially() {}

  onCropIndexChange(String id) {
    bool hasDetails = false;

    

    if (allCalenderRepository.getCalender[id] != null &&
        allCalenderRepository.getCalender[id]!.name.agricultureName != null) {
      hasDetails = true;
    }

    emit(CommonLoading());
    emit(CommonStateSuccess<bool>(data: hasDetails));
  }
}
