import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/news/resource/news_repository.dart';
import 'package:krishi_hub/feature/refrence_contant/model/reference_content_model.dart';

class ReferenceContentCubit extends Cubit<CommonState> {
  final NewsRepository newsRepository;
  ReferenceContentCubit({
    required this.newsRepository,
  }) : super(CommonInitial());

  getReferenceContent({String searchSlug = ""}) async {
    emit(CommonLoading());
    final res = await newsRepository.getReferenceContent();

    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<ReferenceContentModel>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }

  loadMoreReferenceContent({String searchSlug = ""}) async {
    emit(CommonDummyLoading());
    final res =
        await newsRepository.getReferenceContent(searchSlug: searchSlug);
    if (res.status == Status.success) {
      if (res.data != null) {
        if (res.data!.isEmpty) {
          emit(const CommonNoData());
        } else {
          emit(
            CommonDataFetchSuccess<ReferenceContentModel>(data: res.data!),
          );
        }
      } else {
        emit(CommonDataFetchSuccess<String>(data: newsRepository.getItems));
      }
    } else {
      emit(CommonDataFetchSuccess<String>(data: newsRepository.getItems));
    }
  }
}
