import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/krishi_knowledge/resources/krishi_repository.dart';

class GetKrishiCubit extends Cubit<CommonState> {
  final KrishiRepository krishiRepository;
  GetKrishiCubit({required this.krishiRepository}) : super(CommonInitial());

  getKrishi() async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await krishiRepository.getkrishi();
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

  reloadKrishi() async {
    emit(CommonDummyLoading());

    await Future.delayed(const Duration(milliseconds: 200));
    final res = await krishiRepository.getkrishi();
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
