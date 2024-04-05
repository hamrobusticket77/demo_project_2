import 'package:flutter/material.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/hive/hive_storage.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/traning/model/training_model.dart';
import 'package:krishi_hub/feature/traning/resources/all_training_repository.dart';
import 'package:krishi_hub/feature/traning/resources/traning_api_provider.dart';
import 'package:krishi_hub/http/api_provider.dart';
import 'package:krishi_hub/common/response/response.dart';

class TrainingRepository {
  final Env env;
  final ApiProvider apiProvider;
  late TraningApiProvider traningApiProvider;
  final AuthRepository authRepository;
  final AllTraningRepositiry allTraningRepository;

  TrainingRepository({
    required this.apiProvider,
    required this.env,
    required this.authRepository,
    required this.allTraningRepository,
  }) {
    traningApiProvider = TraningApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      authRepository: authRepository,
    );
  }

  int _currentPage = 1;
  int _totalPage = 0;
  final List<String> _items = [];
  List<String> get getItems => _items;

  Future<DataResponse<List<String>>> getTrainingList(
      {bool isLoadMore = false, String searchSlug = ""}) async {
    List<TrainingModel> temp = [];

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

      final res = await traningApiProvider.getTraning(
        currentPage: _currentPage,
        searchSlug: searchSlug,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => TrainingModel.fromMap(e))
          .toList();
      _currentPage = res['pagination']?['currentPages'] ?? _currentPage;
      _totalPage = res['pagination']?['total'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allTraningRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      if (_currentPage == 1) {
        if (temp.isNotEmpty) {
          await HiveStorage()
              .setListValues<TrainingModel>(HiveStorage().trainingList, temp);
        }
      }

      return DataResponse.success(_items);
    } catch (e) {
      debugPrint(e.toString());
      if (isLoadMore) {
        _currentPage--;
      }

      if (_currentPage == 1) {
        _items.clear();
        allTraningRepository.removeAll();
        temp = await HiveStorage()
            .getListValues<TrainingModel>(HiveStorage().trainingList);
        if (temp.isNotEmpty) {
          for (int i = 0; i < temp.length; i++) {
            allTraningRepository.addAll({temp[i].id: temp[i]});
            _items.add(temp[i].id);
          }
          return DataResponse.success(_items);
        }
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> applyTraning({
    required String id,
  }) async {
    try {
      final body = <String, dynamic>{
        "id": id,
      };
      await traningApiProvider.applyTraning(body: body);
      return DataResponse.success(true);
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<TrainingModel>> getTrainingDetails(String id) async {
    try {
      final res = await traningApiProvider.getTrainingDetails(id);

      TrainingModel temp = TrainingModel.fromMap(res['data']?['data'] ?? {});

      await HiveStorage()
          .setValueById<TrainingModel>(HiveStorage().trainingDetails, temp, id);

      return DataResponse.success(temp);
    } catch (e) {
      final temp = await HiveStorage()
          .getValueById<TrainingModel>(HiveStorage().trainingDetails, id);
      if (temp != null) {
        return DataResponse.success(temp);
      }
      debugPrint(e.toString());

      return DataResponse.error(e.toString());
    }
  }
}
