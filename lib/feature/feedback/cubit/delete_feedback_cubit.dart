import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/feature/feedback/resource/feedback_repository.dart';
import 'package:krishi_hub/common/response/response.dart';

class DeleteFeedback extends Cubit<CommonState> {
  final FeedbackRepository feedbackRepository;
  DeleteFeedback({required this.feedbackRepository}) : super(CommonInitial());

  deleteAgriculturePlan({
    required String id,
  }) async {
    emit(CommonLoading());
    final res = await feedbackRepository.deleteFeedback(id: id);

    if (res.status == Status.success) {
      emit(CommonSuccess());
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }
}
