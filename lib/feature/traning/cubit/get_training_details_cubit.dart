import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/traning/model/training_model.dart';
import 'package:krishi_hub/feature/traning/resources/traning_repository.dart';

class GetTrainingDetailsCubit extends Cubit<CommonState> {
  final TrainingRepository traningRepository;
  GetTrainingDetailsCubit({required this.traningRepository})
      : super(CommonInitial());

  getTrainingDetails(String id) async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await traningRepository.getTrainingDetails(id);
    if (res.status == Status.success) {
      emit(CommonStateSuccess<TrainingModel>(data: res.data!));
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }
}
