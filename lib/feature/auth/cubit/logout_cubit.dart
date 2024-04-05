import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';

class LogoutCubit extends Cubit<CommonState> {
  final AuthRepository authRepository;
  LogoutCubit({required this.authRepository}) : super(CommonInitial());

  logout() async {
    emit(CommonLoading());
    final res = await authRepository.logout();
    if (res.status == Status.success) {
      emit(CommonSuccess());
    } else {
      emit(CommonError(message: res.message ?? ""));
    }
  }
}
