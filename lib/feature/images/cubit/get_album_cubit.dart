import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/images/resources/images_repository.dart';

import '../../../common/cubit/data_state.dart';
import '../../../common/response/response.dart';

class GetAlbumCubit extends Cubit<CommonState> {
  final ImagesRepository imagesRepository;
  GetAlbumCubit({required this.imagesRepository}) : super(CommonInitial());

  getAlbum() async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await imagesRepository.getAlbum();
    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<int>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }

  loadMore({String? searchItem}) async {
    emit(CommonDummyLoading());
    final res = await imagesRepository.getAlbum(
      isLoadMore: true,
    );
    if (res.status == Status.success) {
      if (res.data != null) {
        if (res.data!.isEmpty) {
          emit(const CommonNoData());
        } else {
          emit(
            CommonDataFetchSuccess<int>(data: res.data!),
          );
        }
      } else {
        emit(CommonDataFetchSuccess<int>(data: imagesRepository.getItems));
      }
    } else {
      emit(CommonDataFetchSuccess<int>(data: imagesRepository.getItems));
    }
  }
}
