import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/feature/project/resource/project_repository.dart';
import 'package:krishi_hub/common/response/response.dart';

class ProgramCubit extends Cubit<CommonState> {
  final ProjectRepository projectRepository;
  ProgramCubit({required this.projectRepository}) : super(CommonInitial());

  getProgram({required String fiscalYearId}) async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await projectRepository.getProgram(fiscalYearId: fiscalYearId);
    if (res.status == Status.success && res.data != null) {
      if (res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<String>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }

  loadMoreProgram({String? searchItem, required String fiscalYearId}) async {
    emit(CommonDummyLoading());
    final res = await projectRepository.getProgram(
      isLoadMore: true,
      fiscalYearId: fiscalYearId,
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
        emit(CommonDataFetchSuccess<String>(data: projectRepository.getItems));
      }
    } else {
      emit(CommonDataFetchSuccess<String>(data: projectRepository.getItems));
    }
  }
}
