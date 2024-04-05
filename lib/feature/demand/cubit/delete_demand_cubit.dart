import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/feature/demand/resource/demand_repository.dart';
import 'package:krishi_hub/common/response/response.dart';

class DeleteDemand extends Cubit<CommonState> {
  final DemandRepository demandRepository;
  DeleteDemand({required this.demandRepository}) : super(CommonInitial());

  deleteAgriculturePlan({
    required String id,
  }) async {
    emit(CommonLoading());
    final res = await demandRepository.deleteDemand(id: id);

    if (res.status == Status.success) {
      emit(CommonSuccess());
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }
}
