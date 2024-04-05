import 'dart:io';

import 'package:krishi_hub/common/model/photos.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/feature/agriculture_plan/resources/agriculture_repository.dart';

class AgricultureCubit extends Cubit<CommonState> {
  final AgricultureRepository agricultureRepository;
  AgricultureCubit({
    required this.agricultureRepository,
  }) : super(CommonInitial());

  createAgriculturePlan({
    required String fiscalYearId,
    required String program,
    required String project,
    required String planningService,
    required String farmerType,
    required String contactPersonName,
    required String benefittedHHS,
    required String totalCost,
    required String municipalityExpectedCost,
    required String landArea,
    required String activities,
    required String remarks,
    required List<File> image,
  }) async {
    emit(CommonLoading());
    final res = await agricultureRepository.createAgriculturePlan(
        fiscalYearId: fiscalYearId,
        program: program,
        project: project,
        planningService: planningService,
        farmerType: farmerType,
        contactPersonName: contactPersonName,
        benefittedHHS: benefittedHHS,
        totalCost: totalCost,
        municipalityExpectedCost: municipalityExpectedCost,
        landArea: landArea,
        activities: activities,
        remarks: remarks,
        image: image);

    if (res.status == Status.success) {
      emit(CommonSuccess());
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }

  udpateAgriculturePlan({
    required String fiscalYearId,
    required String program,
    required String project,
    required String planningService,
    required String farmerType,
    required String contactPersonName,
    required String benefittedHHS,
    required String totalCost,
    required String municipalityExpectedCost,
    required String landArea,
    required String activities,
    required String remarks,
    required List<File> image,
    required List<Photos> deletedMedia,
    required int? mediaId,
    required String id,
  }) async {
    emit(CommonLoading());
    final res = await agricultureRepository.updateAgriculturePlan(
      fiscalYearId: fiscalYearId,
      program: program,
      project: project,
      planningService: planningService,
      farmerType: farmerType,
      contactPersonName: contactPersonName,
      benefittedHHS: benefittedHHS,
      totalCost: totalCost,
      municipalityExpectedCost: municipalityExpectedCost,
      landArea: landArea,
      activities: activities,
      remarks: remarks,
      image: image,
      deletedMedia: deletedMedia,
      id: id,
      mediaId: mediaId,
    );

    if (res.status == Status.success) {
      emit(CommonSuccess());
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }
}
