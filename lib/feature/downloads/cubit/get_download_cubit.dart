import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/downloads/resources/download_repository.dart';
import '../../../common/cubit/data_state.dart';
import '../../../common/response/response.dart';

class DownloadCubit extends Cubit<CommonState> {
  final DownloadRepository downloadRepository;
  DownloadCubit({required this.downloadRepository}) : super(CommonInitial());

  getDownloadPdf() async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await downloadRepository.getdownloadpdf();
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

  loadMoreNews({String? searchItem}) async {
    emit(CommonDummyLoading());
    final res = await downloadRepository.getdownloadpdf(
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
        emit(CommonDataFetchSuccess<String>(data: downloadRepository.getItems));
      }
    } else {
      emit(CommonDataFetchSuccess<String>(data: downloadRepository.getItems));
    }
  }
}
