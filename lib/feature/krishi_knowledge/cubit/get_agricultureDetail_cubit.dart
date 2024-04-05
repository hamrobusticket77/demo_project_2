import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_name.dart';
import 'package:krishi_hub/feature/krishi_knowledge/resources/krishi_repository.dart';

class GetAgricultureDetailCubit extends Cubit<CommonState> {
  final KrishiRepository krishiRepository;
  GetAgricultureDetailCubit({required this.krishiRepository})
      : super(CommonInitial());

  getAgricultureDetail({required int id, required String type}) async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await krishiRepository.getAgricultureDetail(id, type);
    if (res.status == Status.success) {
      if (res.data != null &&
          res.data!.details != null &&
          res.data!.details!.values.isNotEmpty) {
        emit(CommonStateSuccess<AgricultureName>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }
}
