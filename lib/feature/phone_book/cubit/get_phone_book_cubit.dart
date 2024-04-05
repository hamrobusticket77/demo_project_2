import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/phone_book/resources/phone_book_repository.dart';

class GetPhoneBookCubit extends Cubit<CommonState> {
  final PhoneBookRepository phoneBookRepository;
  GetPhoneBookCubit({
    required this.phoneBookRepository,
  }) : super(CommonInitial());

  getPhoneBook({String searchSlug = ""}) async {
    emit(CommonLoading());
    final res = await phoneBookRepository.getPhoneBook(searchSlug: searchSlug);
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

  loadMorePhoneList({String searchSlug = ""}) async {
    emit(CommonDummyLoading());
    final res = await phoneBookRepository.getPhoneBook(
      isLoadMore: true,
      searchSlug: searchSlug,
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
        emit(
            CommonDataFetchSuccess<String>(data: phoneBookRepository.getItems));
      }
    } else {
      emit(CommonDataFetchSuccess<String>(data: phoneBookRepository.getItems));
    }
  }
}
