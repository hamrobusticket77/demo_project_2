import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/feature/feedback/resource/feedback_repository.dart';
import 'package:krishi_hub/common/response/response.dart';

class FeedbackCubit extends Cubit<CommonState> {
  FeedbackRepository feedbackrepository;
  FeedbackCubit({required this.feedbackrepository}) : super(CommonInitial());

  createfeedback({
    required String name,
    required String email,
    required String phoneNumber,
    required String title,
    required String description,
  }) async {
    emit(CommonLoading());
    final res = await feedbackrepository.createFeedback(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      title: title,
      description: description,
    );

    if (res.status == Status.success) {
      // debugPrint("hello");
      emit(CommonSuccess());
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }
}
