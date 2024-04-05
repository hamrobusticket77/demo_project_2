import 'package:flutter/material.dart';
import 'package:krishi_hub/feature/vission/model/vission_model.dart';
import 'package:krishi_hub/feature/vission/resource/vision_api_provider.dart';
import '../../../common/constant/env.dart';
import '../../../common/response/response.dart';
import '../../../http/api_provider.dart';
import 'all_mission_repository.dart';

class MissionRepository {
  final AllMissionRepository allMissionRepository;
  Env env;

  final ApiProvider apiProvider;

  late MissionApiProvider missionApiProvider;

  MissionRepository({
    required this.env,
    required this.allMissionRepository,
    required this.apiProvider,
  }) {
    missionApiProvider =
        MissionApiProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  final int _currentPage = 1;
  final int _totalPage = 0;
  final List<String> _items = [];
  List<String> get getItems => _items;

  Future<DataResponse<List<String>>> getmission(
      {bool isLoadMore = false}) async {
    List<MissionModel> temp = [];

    try {
      final res = await missionApiProvider.getMission(
        currentPage: _currentPage,
      );

      temp = List.from(res['data']?['data'] ?? [])
          .map((e) => MissionModel.fromMap(e))
          .toList();

      for (int i = 0; i < temp.length; i++) {
        allMissionRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      return DataResponse.success(_items);
    } catch (e) {
      debugPrint(e.toString());

      return DataResponse.error(e.toString());
    }
  }
}
