import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/feature/project/resource/project_repository.dart';
import 'package:krishi_hub/common/response/response.dart';

class SeedCategoryCubit extends Cubit<CommonState> {
  final ProjectRepository projectRepository;
  SeedCategoryCubit({required this.projectRepository}) : super(CommonInitial());

  getSeedCategory() async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await projectRepository.getSeedCategory();
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

  loadMoreSeedCategory({String? searchItem}) async {
    emit(CommonDummyLoading());
    final res = await projectRepository.getSeedCategory(
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
        emit(CommonDataFetchSuccess<String>(data: projectRepository.getItems));
      }
    } else {
      emit(CommonDataFetchSuccess<String>(data: projectRepository.getItems));
    }
  }
}
