import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/feature/office_setup/resources/call_center_repository.dart';
import 'package:krishi_hub/common/response/response.dart';

class GetAnswerQuestionCubit extends Cubit<CommonState> {
  final CallCenterRepository callcenterRepository;
  GetAnswerQuestionCubit({required this.callcenterRepository})
      : super(CommonInitial());

  getAnswerQuestion() async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await callcenterRepository.getanswerquestionlist();
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
