import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';

class LoginCubit extends Cubit<CommonState> {
  final AuthRepository authRepository;
  LoginCubit({required this.authRepository}) : super(CommonInitial());

  login({
    required String phoneNumber,
    required String password,
    required bool isRememberMe
  }) async {
    emit(CommonLoading());
    final res = await authRepository.login(
      phoneNumber: phoneNumber,
      password: password,
      isRememberMe: isRememberMe
    );
    if (res.status == Status.success) {
      emit(CommonStateSuccess(data: res.data!));
    } else {
      emit(CommonError(message: res.message ?? ""));
    }
  }
}
