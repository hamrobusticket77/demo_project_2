// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/expertise/resources/expertise_repository.dart';

class ExpertiseCubit extends Cubit<CommonState> {
  final ExpertiseRepository expertiseRepository;
  ExpertiseCubit({
    required this.expertiseRepository,
  }) : super(CommonInitial());

  getExpertise({
    String? type,
    String? category,
    String? search,
  }) async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await expertiseRepository.getExpertise(
      type: type,
      category: category,
      searchSlug: search ?? "",
    );
    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<String>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "Opps something went worng"));
    }
  }

  loadMoreExdpertise() async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await expertiseRepository.getExpertise();
    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<String>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "Opps SomeThing Went Worng"));
    }
  }
}
