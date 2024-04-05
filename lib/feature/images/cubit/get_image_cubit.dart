import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/images/model/images_model.dart';
import 'package:krishi_hub/feature/images/resources/images_repository.dart';

import '../../../common/cubit/data_state.dart';
import '../../../common/response/response.dart';

class GetImagesCubit extends Cubit<CommonState> {
  final ImagesRepository imagesRepository;
  GetImagesCubit({required this.imagesRepository}) : super(CommonInitial());

  getImage(int id) async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await imagesRepository.getImage(id);
    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<ImagesModel>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }
}
