import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/cubit/data_state.dart';
import '../../../common/response/response.dart';
import '../resources/organization_repository.dart';

class GetOrganizationCubit extends Cubit<CommonState> {
  final OrganizationRepository organizationRepository;
  GetOrganizationCubit({required this.organizationRepository}) : super(CommonInitial());

  getOrganization() async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await organizationRepository.getnews();
    if (res.status == Status.success ) {
      if (res.data!=null &&  res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<String>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }

  
  }

  // loadMoreNews({String? searchItem}) async {
  //   emit(CommonDummyLoading());
  //   final res = await newsRepository.getnews(
  //     isLoadMore: true,
  //   );
  //   if (res.status == Status.success) {
  //     if (res.data != null) {
  //       if (res.data!.isEmpty) {
  //         emit(const CommonNoData());
  //       } else {
  //         emit(
  //           CommonDataFetchSuccess<String>(data: res.data!),
  //         );
  //       }
  //     } else {
  //       emit(CommonDataFetchSuccess<String>(data: newsRepository.getItems));
  //     }
  //   } else {
  //     emit(CommonDataFetchSuccess<String>(data: newsRepository.getItems));
  //   }
  // }
}
