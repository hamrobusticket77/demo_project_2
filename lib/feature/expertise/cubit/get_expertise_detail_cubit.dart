import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/crop_care/model/doctor_record_model.dart';
import 'package:krishi_hub/feature/expertise/resources/expertise_repository.dart';

class GetExpertiseDetailCubit extends Cubit<CommonState> {
  final ExpertiseRepository expertiseRepository;
  GetExpertiseDetailCubit({
    required this.expertiseRepository,
  }) : super(CommonInitial());

  getExpertiseDetail({required String id}) async {
    emit(CommonLoading());
    final res = await expertiseRepository.getExpertiseDetail(id: id);
    if (res.status == Status.success) {
      if (res.data != null) {
        emit(CommonStateSuccess<DoctorRecordModel>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? ""));
    }
  }
}
