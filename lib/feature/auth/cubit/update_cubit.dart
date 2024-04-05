import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';

class UpdateCubit extends Cubit<CommonState> {
  final AuthRepository authRepository;
  UpdateCubit({required this.authRepository}) : super(CommonInitial());

  updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(CommonLoading());
    final res = await authRepository.updatePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    if (res.status == Status.success) {
      emit(CommonStateSuccess(data: res.data!));
    } else {
      emit(CommonError(message: res.message ?? ""));
    }
  }
}
