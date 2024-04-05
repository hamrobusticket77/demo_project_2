import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/krishi_knowledge/resources/krishi_repository.dart';

class GetDiseaseReportCubit extends Cubit<CommonState> {
  final KrishiRepository krishiRepository;
  GetDiseaseReportCubit({required this.krishiRepository})
      : super(CommonInitial());

  getDiseaseReport() async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await krishiRepository.getDiseaseReportList();
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

  loadMoreDiseaseReport() async {
    emit(CommonDummyLoading());
    final res = await krishiRepository.getDiseaseReportList(
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
        emit(CommonDataFetchSuccess<String>(data: krishiRepository.getItems));
      }
    } else {
      emit(CommonDataFetchSuccess<String>(data: krishiRepository.getItems));
    }
  }
}
