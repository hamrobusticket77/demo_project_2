import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/faq/resources/faq_repository.dart';

import '../../../common/cubit/data_state.dart';
import '../../../common/response/response.dart';

class FAQCubit extends Cubit<CommonState> {
  final FAQRepository faqRepository;
  FAQCubit({required this.faqRepository}) : super(CommonInitial());

  getFaq() async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await faqRepository.getfaq();
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

  loadMoreFaq({String? searchItem}) async {
    emit(CommonDummyLoading());
    final res = await faqRepository.getfaq(
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
        emit(CommonDataFetchSuccess<String>(data: faqRepository.getItems));
      }
    } else {
      emit(CommonDataFetchSuccess<String>(data: faqRepository.getItems));
    }
  }
}
