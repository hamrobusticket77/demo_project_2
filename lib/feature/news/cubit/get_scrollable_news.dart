import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/news/model/news_model.dart';

import '../../../common/cubit/data_state.dart';
import '../../../common/response/response.dart';
import '../resource/news_repository.dart';

class GetScrollableNews extends Cubit<CommonState> {
  final NewsRepository newsRepository;
  GetScrollableNews({required this.newsRepository}) : super(CommonInitial());

  getScrollableNews() async {
    emit(CommonLoading());
    final res = await newsRepository.getScrollableNews();
    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<NewsModel>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }

  reloadScrollableNews() async {
    emit(CommonDummyLoading());
    final res = await newsRepository.getScrollableNews();

    await Future.delayed(const Duration(seconds: 5));
    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<NewsModel>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }
}
