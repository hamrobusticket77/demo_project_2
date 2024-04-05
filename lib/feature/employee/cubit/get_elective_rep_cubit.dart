import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/employee/resource/employee_repository.dart';

import '../../../common/cubit/data_state.dart';
import '../../../common/response/response.dart';

class GetElectiveCubit extends Cubit<CommonState> {
  final EmployeeRepository employeeRepository;
  GetElectiveCubit({required this.employeeRepository}) : super(CommonInitial());

  getElectiveRepresentive() async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await employeeRepository.getelectiverepresentive();
    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<String>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }

  loadMoreNews({String? searchItem}) async {
    emit(CommonDummyLoading());
    final res = await employeeRepository.getelectiverepresentive(
      isLoadMore: true,
    );
    if (res.status == Status.success) {
      if (res.data != null) {
        if (res.data!.isEmpty) {
          emit(const CommonNoData());
        } else {
          emit(
            CommonDataFetchSuccess<String>(data: res.data!),
          );
        }
      } else {
        emit(CommonDataFetchSuccess<String>(data: employeeRepository.getItems));
      }
    } else {
      emit(CommonDataFetchSuccess<String>(data: employeeRepository.getItems));
    }
  }
}
