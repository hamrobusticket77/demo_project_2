import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/hive/hive_storage.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/demand/model/applied_demand_model.dart';
import 'package:krishi_hub/feature/demand/model/apply_demand_param.dart';
import 'package:krishi_hub/feature/demand/model/demand_model.dart';
import 'package:krishi_hub/feature/demand/model/demand_param_model.dart';
import 'package:krishi_hub/feature/demand/resource/all_applied_demand_repository.dart';
import 'package:krishi_hub/feature/demand/resource/all_demand_repository.dart';
import 'package:krishi_hub/feature/demand/resource/demand_api_provider.dart';
import 'package:krishi_hub/http/api_provider.dart';
import 'package:krishi_hub/common/response/response.dart';

class DemandRepository {
  final Env env;
  final AuthRepository authRepository;
  late DemandApiProvider demandApiProvider;
  final AllDemandListRepository alldemandlistRepository;

  final AllAppliedDemendRepository allAppliedDemendRepository;

  final ApiProvider apiProvider;

  DemandRepository({
    required this.env,
    required this.authRepository,
    required this.apiProvider,
    required this.alldemandlistRepository,
    required this.allAppliedDemendRepository,
  }) {
    demandApiProvider = DemandApiProvider(
        apiProvider: apiProvider,
        baseUrl: env.baseUrl,
        authRepository: authRepository);
  }

  // getFiscalYear({bool? isLoadMore = false}) async {
  //   try {} on Exception catch (e, s) {
  //     Log.e(e);
  //     Log.i(s);
  //     return DataResponse.error(e.toString());
  //   }
  // }
  int _currentPage = 1;
  int _totalPage = 0;
  final List<String> _items = [];
  List<String> get getItems => _items;

  Future<DataResponse<List<String>>> getdemandlist(
      {bool isLoadMore = false}) async {
    List<DemandModel> temp = [];

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

      final res = await demandApiProvider.getDemand(
        currentPage: _currentPage,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => DemandModel.fromMap(e))
          .toList();
      _currentPage = res['pagination']?['currentPages'] ?? _currentPage;
      _totalPage = res['pagination']?['total'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        alldemandlistRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      if (_currentPage == 1) {
        if (temp.isNotEmpty) {
          await HiveStorage()
              .setListValues<DemandModel>(HiveStorage().demandList, temp);
        }
      }

      return DataResponse.success(_items);
    } catch (e) {
      debugPrint(e.toString());
      if (isLoadMore) {
        _currentPage--;
      }

      if (_currentPage == 1) {
        temp = await HiveStorage()
            .getListValues<DemandModel>(HiveStorage().demandList);

        if (temp.isNotEmpty) {
          alldemandlistRepository.removeAll();
          _items.clear();

          for (int i = 0; i < temp.length; i++) {
            alldemandlistRepository.addAll({temp[i].id: temp[i]});
            _items.add(temp[i].id);
          }
          return DataResponse.success(_items);
        }
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<DemandModel>> getDemandById(String id) async {
    try {
      final res = await demandApiProvider.getDemandById(id);

      DemandModel temp = DemandModel.fromMap(res['data']?['data'] ?? {});

      return DataResponse.success(temp);
    } catch (e) {
      Log.e(e);

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> seedDemand(
      {required String fiscalYearId,
      required String programId,
      required String projectId,
      required List<DemandDetailsParamModel> demandDetails}) async {
    try {
      var body = <String, dynamic>{
        "fiscalYear": fiscalYearId,
        "program": programId,
        "project": projectId,
        "demand": demandDetails.map((e) => e.toJsonForPost()).toList()
      };

      await demandApiProvider.seedDemand(body: body);

      return DataResponse.success(true);
    } catch (e, s) {
      Log.e(e);
      Log.d(s);

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> deleteDemand({required String id}) async {
    try {
      await demandApiProvider.deleteDemand(id: id);

      return DataResponse.success(true);
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> udpateDemand({
    required String fiscalYearId,
    required String programId,
    required String projectId,
    required List<DemandDetailsParamModel> demandDetails,
    required String id,
  }) async {
    try {
      var body = <String, dynamic>{
        "fiscalYear": fiscalYearId,
        "program": programId,
        "project": projectId,
        "demand": demandDetails.map((e) => e.toJsonForPost()).toList(),
        "id": id,
      };

      await demandApiProvider.updateDemand(body: body);

      return DataResponse.success(true);
    } catch (e, s) {
      Log.e(e);
      Log.d(s);

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> applyDemand({
    required List<ApplyDemandParam> demandParam,
  }) async {
    try {
      List<Map<String, dynamic>> data = [];

      for (var element in demandParam) {
        Log.d(element.toMap());

        if (element.appliedQuantity != null) {
          data.add(element.toMap());
        }
      }

      final body = <String, dynamic>{"quantityDetails": data};
      await demandApiProvider.applyDemand(body: body);

      return DataResponse.success(true);
    } catch (e, s) {
      Log.e(e);
      Log.d(s);

      return DataResponse.error(e.toString());
    }
  }

  int _demandCurrentPage = 1;
  int _demandTotalPage = 0;
  final List<String> _demandItems = [];
  List<String> get getDemandItems => _demandItems;

  Future<DataResponse<List<String>>> getAppliedDemand(
      {bool isLoadMore = false}) async {
    List<AppliedDemandModel> temp = [];

    try {
      if (isLoadMore) {
        if (_demandCurrentPage == _demandTotalPage) {
          return DataResponse.success(_demandItems);
        }
        _demandCurrentPage++;
      }
      if (!isLoadMore) {
        _demandItems.clear();
        _demandCurrentPage = 1;
        _demandTotalPage = 0;
      }

      final res = await demandApiProvider.getAppliedDemand(
        currentPage: _demandCurrentPage,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => AppliedDemandModel.fromMap(e))
          .toList();
      _demandCurrentPage =
          res['pagination']?['currentPages'] ?? _demandCurrentPage;
      _demandTotalPage = res['pagination']?['total'] ?? _demandTotalPage;

      for (int i = 0; i < temp.length; i++) {
        allAppliedDemendRepository.addAll({temp[i].id: temp[i]});
        _demandItems.add(temp[i].id);
      }

      return DataResponse.success(_demandItems);
    } catch (e) {
      debugPrint(e.toString());
      if (isLoadMore) {
        _demandCurrentPage--;
      }

      return DataResponse.error(e.toString());
    }
  }
}
