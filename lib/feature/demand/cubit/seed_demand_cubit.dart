import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/feature/demand/model/demand_param_model.dart';
import 'package:krishi_hub/feature/demand/resource/demand_repository.dart';
import 'package:krishi_hub/common/response/response.dart';

class SeedDemandCubit extends Cubit<CommonState> {
  final DemandRepository demandRepository;
  SeedDemandCubit({required this.demandRepository}) : super(CommonInitial());

  seedDemand(
      {required String fiscalYearId,
      required String programId,
      required String projectId,
      required List<DemandDetailsParamModel> demandDetails}) async {
    emit(CommonLoading());
    final res = await demandRepository.seedDemand(
        fiscalYearId: fiscalYearId,
        programId: programId,
        projectId: projectId,
        demandDetails: demandDetails);

    if (res.status == Status.success && res.data == true) {
      emit(CommonSuccess());
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }

  updateDemand({
    required String fiscalYearId,
    required String programId,
    required String projectId,
    required List<DemandDetailsParamModel> demandDetails,
    required String id,
  }) async {
    emit(CommonLoading());
    final res = await demandRepository.udpateDemand(
      fiscalYearId: fiscalYearId,
      programId: programId,
      projectId: projectId,
      demandDetails: demandDetails,
      id: id,
    );

    if (res.status == Status.success && res.data == true) {
      emit(CommonSuccess());
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }
}
