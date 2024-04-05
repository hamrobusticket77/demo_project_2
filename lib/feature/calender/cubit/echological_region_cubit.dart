import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/feature/calender/resource/calender_repository.dart';

class EcologicalRegionCubit extends Cubit<CommonState> {
  final CalenderRepository calenderRepository;
  EcologicalRegionCubit({required this.calenderRepository})
      : super(CommonInitial());

  onChangeEcologicalRegion(String ecologicalRegion, String index) async {
    await calenderRepository.onChangeEcologicalRegion(ecologicalRegion, index);

    emit(CommonSuccess());
    emit(CommonInitial());
  }
}
