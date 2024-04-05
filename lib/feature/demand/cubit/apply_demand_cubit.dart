import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/feature/demand/model/apply_demand_param.dart';
import 'package:krishi_hub/feature/demand/resource/demand_repository.dart';
import 'package:krishi_hub/common/response/response.dart';

class ApplyDemandCubit extends Cubit<CommonState> {
  final DemandRepository demandRepository;
  ApplyDemandCubit({required this.demandRepository}) : super(CommonInitial());

  applyDemand({
    required List<ApplyDemandParam> demandParam,
  }) async {
    emit(CommonLoading());
    final res = await demandRepository.applyDemand(demandParam: demandParam);

    if (res.status == Status.success && res.data == true) {
      emit(CommonSuccess());
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }
}
