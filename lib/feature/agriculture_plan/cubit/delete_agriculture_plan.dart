import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/feature/agriculture_plan/resources/agriculture_repository.dart';
import 'package:krishi_hub/common/response/response.dart';

class DeleteAgricluturePlan extends Cubit<CommonState> {
  final AgricultureRepository agricultureRepository;
  DeleteAgricluturePlan({required this.agricultureRepository})
      : super(CommonInitial());

  deleteAgriculturePlan({
    required String id,
  }) async {
    emit(CommonLoading());
    final res = await agricultureRepository.deleteAgriculturePlan(id: id);

    if (res.status == Status.success) {
      emit(CommonSuccess());
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }
}
