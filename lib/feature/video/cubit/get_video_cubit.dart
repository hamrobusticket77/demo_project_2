import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/cubit/data_state.dart';
import '../../../common/response/response.dart';
import '../resource/video_repository.dart';

class GetVideoCubit extends Cubit<CommonState> {
  final VideoRepository videoRepository;
  GetVideoCubit({required this.videoRepository}) : super(CommonInitial());

  getVideos() async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await videoRepository.getvideo();
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

  reloadVideos() async {
    emit(CommonDummyLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await videoRepository.getvideo();
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

  loadMoreVideo({String? searchItem}) async {
    emit(CommonDummyLoading());
    final res = await videoRepository.getvideo(
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
        emit(CommonDataFetchSuccess<String>(data: videoRepository.getItems));
      }
    } else {
      emit(CommonDataFetchSuccess<String>(data: videoRepository.getItems));
    }
  }
}
