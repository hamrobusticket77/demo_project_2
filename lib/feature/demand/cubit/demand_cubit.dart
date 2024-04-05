import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/feature/demand/model/demand_model.dart';

import 'package:krishi_hub/feature/demand/resource/demand_repository.dart';
import 'package:krishi_hub/common/response/response.dart';

class DemandCubit extends Cubit<CommonState> {
  final DemandRepository demandlistRepository;
  DemandCubit({required this.demandlistRepository}) : super(CommonInitial());

  getDemandById(String id) async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await demandlistRepository.getDemandById(id);
    if (res.status == Status.success) {
      emit(CommonStateSuccess<DemandModel>(data: res.data!));
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }

  // getDemandFormById(String id) async {
  //   emit(CommonLoading());
  //   await Future.delayed(const Duration(milliseconds: 200));
  //   final res = await demandlistRepository.getDemandById(id);
  //   if (res.status == Status.success) {
  //     emit(CommonStateSuccess<DemandModel>(data: res.data!));
  //   } else {
  //     emit(CommonError(message: res.message ?? "something went worng"));
  //   }
  // }
}
