import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/crop_care/model/doctor_record_model.dart';
import 'package:krishi_hub/feature/crop_care/resources/crop_care_repository.dart';

class GetInsuranceDirectoryDetailCubit extends Cubit<CommonState> {
  final CropCareRepository cropCareRepository;
  GetInsuranceDirectoryDetailCubit({
    required this.cropCareRepository,
  }) : super(CommonInitial());

  getInsuranceDirectoryDetailCubit({required String id}) async {
    emit(CommonLoading());
    final res = await cropCareRepository.getInsuranceDirectoryId(id: id);
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
