import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';

import 'package:krishi_hub/feature/demand/resource/demand_repository.dart';
import 'package:krishi_hub/common/response/response.dart';

class GetDemandListCubit extends Cubit<CommonState> {
  final DemandRepository demandlistRepository;
  GetDemandListCubit({required this.demandlistRepository})
      : super(CommonInitial());

  getDemandList() async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await demandlistRepository.getdemandlist();
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

  loadMoreDemandList({String? searchItem}) async {
    emit(CommonDummyLoading());
    final res = await demandlistRepository.getdemandlist(
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
        emit(CommonDataFetchSuccess<String>(
            data: demandlistRepository.getItems));
      }
    } else {
      emit(CommonDataFetchSuccess<String>(data: demandlistRepository.getItems));
    }
  }
}
