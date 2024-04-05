import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';

class FarmerRequestCubit extends Cubit<CommonState> {
  final AuthRepository authRepository;
  FarmerRequestCubit({required this.authRepository}) : super(CommonInitial());

  farmerRequest(
      {required String phoneNumber,
      required String fullName,
      required int wardNumber}) async {
    emit(CommonLoading());
    final res = await authRepository.farmerRequest(
        phoneNumber: phoneNumber, fullName: fullName, wardNumber: wardNumber);
    if (res.status == Status.success) {
      emit(CommonSuccess());
    } else {
      emit(CommonError(message: res.message ?? ""));
    }
  }
}
