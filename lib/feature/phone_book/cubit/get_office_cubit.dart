import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/phone_book/resources/phone_book_repository.dart';

class GetOfficeCubit extends Cubit<CommonState> {
  final PhoneBookRepository phoneBookRepository;
  GetOfficeCubit({
    required this.phoneBookRepository,
  }) : super(CommonInitial());

  getOffice({String searchSlug = "", required String id}) async {
    emit(CommonLoading());
    final res =
        await phoneBookRepository.getOffice(searchSlug: searchSlug, id: id);
    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<String>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? ""));
    }
  }

  loadMoreOfficeList({String searchSlug = "", required String id}) async {
    emit(CommonDummyLoading());
    final res = await phoneBookRepository.getOffice(
      isLoadMore: true,
      searchSlug: searchSlug,
      id: id,
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
        emit(CommonDataFetchSuccess<String>(
            data: phoneBookRepository.getOffices));
      }
    } else {
      emit(
          CommonDataFetchSuccess<String>(data: phoneBookRepository.getOffices));
    }
  }
}
