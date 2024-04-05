import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/vission/resource/vision_repository.dart';

import '../../../common/cubit/data_state.dart';
import '../../../common/response/response.dart';

class GetMissionCubit extends Cubit<CommonState> {
  final MissionRepository missionRepository;
  GetMissionCubit({required this.missionRepository}) : super(CommonInitial());

  getMission() async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await missionRepository.getmission();
    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<String>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }
}
