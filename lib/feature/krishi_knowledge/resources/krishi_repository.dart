import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/hive/hive_storage.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_knowledge_model.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_name.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/disease_report_view_model.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_model.dart';
import 'package:krishi_hub/feature/krishi_knowledge/resources/all_agriculture_knowledge_repository.dart';
import 'package:krishi_hub/feature/krishi_knowledge/resources/all_disease_report_repository.dart';
import 'package:krishi_hub/feature/media/resource/media_repository.dart';
import 'package:krishi_hub/http/api_provider.dart';

import 'all_krishi_repository.dart';
import 'krishi_api_provider.dart';

class KrishiRepository {
  final AllKrishiRepository allkrishiRepository;
  Env env;

  final ApiProvider apiProvider;
  final AuthRepository authRepository;
  late KrishiApiProvider krishiApiProvider;
  final MediaRepository mediaRepository;
  final AllAgricultureKnowledgeRepository allAgricultureKnowledgeRepository;
  final AllDiseaseReportRepository allDiseaseReportRepository;

  KrishiRepository({
    required this.env,
    required this.allkrishiRepository,
    required this.apiProvider,
    required this.authRepository,
    required this.mediaRepository,
    required this.allAgricultureKnowledgeRepository,
    required this.allDiseaseReportRepository,
  }) {
    krishiApiProvider = KrishiApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      authRepository: authRepository,
      globalurl: env.globalBaseUrl,
    );
  }

  int _currentPage = 1;
  int _totalPage = 0;
  final List<String> _items = [];
  List<String> get getItems => _items;

  Future<DataResponse<List<String>>> getAgricultureKnowledge(
      {bool isLoadMore = false, required String type}) async {
    List<AgricultureKnowledgeModel> temp = [];

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

      final res = await krishiApiProvider.getAgricultureKnowledge(
        currentPage: _currentPage,
        type: type,
      );
      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => AgricultureKnowledgeModel.fromMap(e))
          .toList();

      for (int i = 0; i < temp.length; i++) {
        allAgricultureKnowledgeRepository
            .addAll({temp[i].id.toString(): temp[i]});
        _items.add(temp[i].id.toString());
      }

      return DataResponse.success(_items);
    } catch (e) {
      debugPrint(e.toString());
      if (isLoadMore) {
        _currentPage--;
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<String>>> getkrishi(
      {bool isLoadMore = false}) async {
    List<AgricultureModel> temp = [];

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

      final res = await krishiApiProvider.getKrishi(
        currentPage: _currentPage,
      );
      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => AgricultureModel.fromMap(e))
          .toList();

      for (int i = 0; i < temp.length; i++) {
        allkrishiRepository.addAll({temp[i].id.toString(): temp[i]});
        _items.add(temp[i].id.toString());
      }

      if (_currentPage == 1 && temp.isNotEmpty) {
        final box =
            Hive.box<AgricultureModel>(HiveStorage().krishiKnowledgeList);
        await box.clear();
        await box.addAll(temp);
      }

      return DataResponse.success(_items);
    } catch (e) {
      debugPrint(e.toString());
      if (isLoadMore) {
        _currentPage--;
      }

      if (!isLoadMore) {
        final box =
            Hive.box<AgricultureModel>(HiveStorage().krishiKnowledgeList);
        temp = box.values.toList();
        if (temp.isNotEmpty) {
          for (int i = 0; i < temp.length; i++) {
            allkrishiRepository.addAll({temp[i].id.toString(): temp[i]});
            _items.add(temp[i].id.toString());
          }
          return DataResponse.success(_items);
        }
      }

      return DataResponse.error(e.toString());
    }
  }

  int _currentPageReportedDisease = 1;
  int _totalPageReportedDisease = 0;
  final List<String> _itemsReportedDisease = [];
  List<String> get getItemsReportedDisease => _itemsReportedDisease;

  Future<DataResponse<List<String>>> getDiseaseReportList(
      {bool isLoadMore = false}) async {
    List<DiseaseReportViewModel> temp = [];

    try {
      if (isLoadMore) {
        if (_currentPageReportedDisease == _totalPageReportedDisease) {
          return DataResponse.success(_itemsReportedDisease);
        }
        _currentPageReportedDisease++;
      }
      if (!isLoadMore) {
        _itemsReportedDisease.clear();
        _currentPageReportedDisease = 1;
        _totalPageReportedDisease = 0;
      }

      final res = await krishiApiProvider.getDiseaseReportList(
        currentPage: _currentPageReportedDisease,
      );
      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => DiseaseReportViewModel.fromMap(e))
          .toList();
      _currentPageReportedDisease = res['data']?['data']['pagination']
              ?['currentPages'] ??
          _currentPageReportedDisease;
      _totalPageReportedDisease = res['data']?['data']['pagination']
              ?['totalPages'] ??
          _totalPageReportedDisease;
      for (int i = 0; i < temp.length; i++) {
        allDiseaseReportRepository.addAll({temp[i].id.toString(): temp[i]});
        _itemsReportedDisease.add(temp[i].id.toString());
      }

      return DataResponse.success(_itemsReportedDisease);
    } catch (e) {
      debugPrint(e.toString());
      if (isLoadMore) {
        _currentPageReportedDisease--;
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<AgricultureName>>> getHomeKrisi(
      {bool isLoadMore = false}) async {
    List<AgricultureModel> temp = [];

    List<AgricultureName> value = [];

    try {
      final res = await krishiApiProvider.getKrishi(
        currentPage: _currentPage,
      );
      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => AgricultureModel.fromMap(e))
          .toList();
      if (temp.isNotEmpty) {
        if (temp[0].agricultureType.isNotEmpty) {
          value = temp[0].agricultureType[0].agricultureName;
        }
      }

      if (value.isNotEmpty) {
        await HiveStorage().setListValues<AgricultureName>(
            HiveStorage().krishiKnowledgeHome, value);
      }

      return DataResponse.success(value);
    } catch (e) {
      debugPrint(e.toString());

      value = await HiveStorage()
          .getListValues<AgricultureName>(HiveStorage().krishiKnowledgeHome);
      if (value.isNotEmpty) {
        return DataResponse.success(value);
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<AgricultureName>> getAgricultureItem(int id) async {
    try {
      final res = await krishiApiProvider.getAgricultureItem(id);

      AgricultureName temp = AgricultureName.fromMap(res['data']?['data']);

      await HiveStorage().setValueById<AgricultureName>(
          HiveStorage().knowledgeDetails, temp, id.toString());

      return DataResponse.success(temp);
    } catch (e) {
      Log.e(e);

      final temp = await HiveStorage().getValueById<AgricultureName>(
          HiveStorage().knowledgeDetails, id.toString());

      if (temp != null) {
        return DataResponse.success(temp);
      }
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<AgricultureName>> getAgricultureDetail(
      int id, String type) async {
    try {
      final res =
          await krishiApiProvider.getAgricultureKnowledgeDetail(id, type: type);

      AgricultureName temp = AgricultureName.fromMap(res['data']?['data']);

      return DataResponse.success(temp);
    } catch (e) {
      Log.e(e);

      // final temp = await HiveStorage().getValueById<AgricultureName>(
      //     HiveStorage().knowledgeDetails, id.toString());

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> createDiseaseReport(
      {required String category,
      required String crops,
      required String title,
      required String description,
      required List<File> image}) async {
    try {
      List<String> mediaId = [];
      if (image.isNotEmpty) {
        mediaId = await mediaRepository.mediaUploadWithMediaROute(
          file: image,
          relatedTo: "DISEASE",
        );
      }

      final body = <String, dynamic>{
        "category": category,
        "crops": crops,
        "title": title,
        "description": description,
      };

      if (mediaId.isNotEmpty) {
        body['media'] = mediaId;
      }
      await krishiApiProvider.createDiseaseReport(body: body);
      return DataResponse.success(true);
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }
}
