import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/news/resource/news_repository.dart';
import 'package:krishi_hub/feature/refrence_contant/model/reference_content_model.dart';

class GetReferenceCubitId extends Cubit<CommonState> {
  final NewsRepository newsRepository;
  GetReferenceCubitId({
    required this.newsRepository,
  }) : super(CommonInitial());

  getReferenceContentByid({required String id}) async {
    emit(CommonLoading());
    final res = await newsRepository.getReferenceContentById(id: id);

    if (res.status == Status.success) {
      if (res.data != null) {
        emit(CommonStateSuccess<ReferenceContentModel>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }
}
