import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/cubit/data_state.dart';
import '../../../common/response/response.dart';
import '../resource/news_repository.dart';

class GetNewsDialog extends Cubit<CommonState> {
  final NewsRepository newsRepository;
  GetNewsDialog({required this.newsRepository}) : super(CommonInitial());

  getNewsDialog() async {
    emit(CommonLoading());
    final res = await newsRepository.getnews();
    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        // emit(CommonStateSuccess<String>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }
}
