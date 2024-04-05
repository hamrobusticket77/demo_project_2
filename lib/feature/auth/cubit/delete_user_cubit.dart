import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';

class DeleteUserCubit extends Cubit<CommonState> {
  final AuthRepository authRepository;
  DeleteUserCubit({required this.authRepository}) : super(CommonInitial());

  deleteUser(
      {required String phoneNumber,
      required String password,
      required String reasonToDelete}) async {
    emit(CommonLoading());
    final res = await authRepository.deleteUser(
        phoneNumber: phoneNumber,
        password: password,
        reasonToDelete: reasonToDelete);
    if (res.status == Status.success) {
      emit(CommonStateSuccess(data: res.data!));
    } else {
      emit(CommonError(message: res.message ?? ""));
    }
  }
}
