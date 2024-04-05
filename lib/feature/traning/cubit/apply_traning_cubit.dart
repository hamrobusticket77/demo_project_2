import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/traning/resources/traning_repository.dart';

class ApplyTrainingCubit extends Cubit<CommonState> {
  final TrainingRepository traningRepository;
  ApplyTrainingCubit({required this.traningRepository})
      : super(CommonInitial());

  applyTraining({
    required String id,
  }) async {
    emit(CommonLoading());
    final res = await traningRepository.applyTraning(id: id);

    if (res.status == Status.success) {
      emit(CommonSuccess());
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }
}
