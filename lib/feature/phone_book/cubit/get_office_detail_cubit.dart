import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/phone_book/model/office_model.dart';
import 'package:krishi_hub/feature/phone_book/resources/phone_book_repository.dart';

class GetOfficeDetailCubit extends Cubit<CommonState> {
  final PhoneBookRepository phoneBookRepository;
  GetOfficeDetailCubit({
    required this.phoneBookRepository,
  }) : super(CommonInitial());

  getOfficeDetail({required String id}) async {
    emit(CommonLoading());
    final res = await phoneBookRepository.getOfficeDetail(id: id);
    if (res.status == Status.success) {
      if (res.data != null) {
        emit(CommonStateSuccess<OfficeModel>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? ""));
    }
  }
}
