import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/krishi_knowledge/resources/krishi_repository.dart';

class DiseaseReportCubit extends Cubit<CommonState> {
  final KrishiRepository krishiRepository;
  DiseaseReportCubit({
    required this.krishiRepository,
  }) : super(CommonInitial());

  createDiseaseReport({
    required String category,
    required String crops,
    required String title,
    required String description,
    required List<File> image,
  }) async {
    emit(CommonLoading());
    final res = await krishiRepository.createDiseaseReport(
      image: image,
      category: category,
      crops: crops,
      title: title,
      description: description,
    );

    if (res.status == Status.success) {
      emit(CommonSuccess());
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }
}
