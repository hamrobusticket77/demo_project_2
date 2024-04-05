import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/feature/feedback/resource/feedback_repository.dart';
import 'package:krishi_hub/common/response/response.dart';

class GetFeedbackCubit extends Cubit<CommonState> {
  final FeedbackRepository feedbackRepository;
  GetFeedbackCubit({required this.feedbackRepository}) : super(CommonInitial());

  getFeedback() async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await feedbackRepository.getfedbacklist();
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

  loadMoreFeedback({String? searchItem}) async {
    emit(CommonDummyLoading());
    final res = await feedbackRepository.getfedbacklist(
      isLoadMore: true,
    );
    if (res.status == Status.success) {
      if (res.data != null) {
        if (res.data!.isEmpty) {
          emit(const CommonNoData());
        } else {
          emit(
            CommonDataFetchSuccess<String>(data: res.data!),
          );
        }
      } else {
        emit(CommonDataFetchSuccess<String>(data: feedbackRepository.getItems));
      }
    } else {
      emit(CommonDataFetchSuccess<String>(data: feedbackRepository.getItems));
    }
  }
}
