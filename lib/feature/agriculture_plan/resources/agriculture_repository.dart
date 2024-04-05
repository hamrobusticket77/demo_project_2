import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/hive/hive_storage.dart';
import 'package:krishi_hub/common/model/photos.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/feature/agriculture_plan/model/agriculture_plan_model.dart';
import 'package:krishi_hub/feature/agriculture_plan/resources/agriculture_api_provider.dart';
import 'package:krishi_hub/feature/agriculture_plan/resources/all_agriculture_plan_repository.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/media/resource/media_repository.dart';
import 'package:krishi_hub/http/api_provider.dart';
import 'package:krishi_hub/common/response/response.dart';

class AgricultureRepository {
  final Env env;
  final AuthRepository authRepository;
  late AgriculturePlanApiProvider agricultureplanApiProvider;
  final AllAgricultureRepository allAgricultureRepository;
  final MediaRepository mediaRepository;
  final ApiProvider apiProvider;

  AgricultureRepository({
    required this.apiProvider,
    required this.env,
    required this.authRepository,
    required this.allAgricultureRepository,
    required this.mediaRepository,
  }) {
    agricultureplanApiProvider = AgriculturePlanApiProvider(
      apiProvider: apiProvider,
      baseUrl: env.baseUrl,
      authRepository: authRepository,
    );
  }

  int _currentPage = 1;
  int _totalPage = 0;
  final List<String> _items = [];
  List<String> get getItems => _items;

  Future<DataResponse<List<String>>> getagricultureplanlist(
      {bool isLoadMore = false}) async {
    List<AgriculturePlanModel> temp = [];

    try {
      if (isLoadMore) {
        if (_currentPage == _totalPage) {
          return DataResponse.success(_items);
        }
        _currentPage++;
      }
      if (!isLoadMore) {
        _items.clear();
        _currentPage = 1;
        _totalPage = 0;
      }

      final res = await agricultureplanApiProvider.getagricultureplan(
        currentPage: _currentPage,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => AgriculturePlanModel.fromJson(e))
          .toList();
      _currentPage = res['pagination']?['currentPages'] ?? _currentPage;
      _totalPage = res['pagination']?['total'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allAgricultureRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      if (_currentPage == 1 && temp.isNotEmpty) {
        final box =
            Hive.box<AgriculturePlanModel>(HiveStorage().agriculturePlanList);

        await box.clear();
        await box.addAll(temp);
      }

      return DataResponse.success(_items);
    } catch (e) {
      debugPrint(e.toString());
      if (isLoadMore) {
        _currentPage--;
      }

      if (_currentPage == 1) {
        final box =
            Hive.box<AgriculturePlanModel>(HiveStorage().agriculturePlanList);

        temp = box.values.toList();
        if (temp.isNotEmpty) {
          _items.clear();
          allAgricultureRepository.removeAll();

          for (int i = 0; i < temp.length; i++) {
            allAgricultureRepository.addAll({temp[i].id: temp[i]});
            _items.add(temp[i].id);
          }

          return DataResponse.success(_items);
        }
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> createAgriculturePlan(
      {required String fiscalYearId,
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
      required List<File> image}) async {
    try {
      String mediaId = '';
      if (image.isNotEmpty) {
        mediaId = await mediaRepository.mediaUpload(
          file: image,
          relatedTo: "ProjectForm",
        );
      }

      final body = <String, dynamic>{
        "farmerType": farmerType,
        "contactPersonName": contactPersonName,
        "benefittedHHS": benefittedHHS,
        "totalCost": totalCost,
        "municipalityExpectedCost": municipalityExpectedCost,
        "landArea": landArea,
        "activities": activities,
        "remarks": remarks,
        "fiscalYear": fiscalYearId,
        "program": program,
        "project": project,
        "planningService": planningService,
        //"media": mediaId,
      };
      if (image.isNotEmpty) {
        body['media'] = mediaId;
      }
      await agricultureplanApiProvider.createAgriculturePlan(body: body);
      return DataResponse.success(true);
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> updateAgriculturePlan({
    required String id,
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
  }) async {
    try {
      debugPrint(authRepository.user.value?.id ?? "");
      var _mediaId;

      if (mediaId == null) {
        if (image.isNotEmpty) {
          _mediaId = await mediaRepository.mediaUpload(
              file: image, relatedTo: "ProjectForm");
        }
      } else {
        _mediaId = await mediaRepository.mediaUpdate(
            file: image,
            deletedMedia: deletedMedia.map((e) => e.id).toList(),
            mediaId: mediaId,
            relatedTo: "ProjectForm");
      }

      final body = <String, dynamic>{
        "farmerType": farmerType,
        "contactPersonName": contactPersonName,
        "benefittedHHS": benefittedHHS,
        "totalCost": totalCost,
        "municipalityExpectedCost": municipalityExpectedCost,
        "landArea": landArea,
        "activities": activities,
        "remarks": remarks,
        "fiscalYear": fiscalYearId,
        "program": program,
        "project": project,
        "planningService": planningService,
        "media": _mediaId,
        "id": id,
      };

      if (mediaId != null) {
        body['media'] = _mediaId;
      }

      if (image.isNotEmpty) {
        body['media'] = _mediaId;
      }

      await agricultureplanApiProvider.updateAgriculturePlan(body: body);
      return DataResponse.success(true);
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> deleteAgriculturePlan({required String id}) async {
    try {
      await agricultureplanApiProvider.deleteAgriculturePlan(id: id);

      return DataResponse.success(true);
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }
}
