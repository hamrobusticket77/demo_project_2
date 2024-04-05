import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/hive/hive_storage.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/crop_care/constant/store_type_enum.dart';
import 'package:krishi_hub/feature/crop_care/model/doctor_record_model.dart';
import 'package:krishi_hub/feature/crop_care/model/fertilizer_store_model.dart';
import 'package:krishi_hub/feature/crop_care/resources/all_doctor_record_repository.dart';
import 'package:krishi_hub/feature/crop_care/resources/all_fertilizer_store_repository.dart';
import 'package:krishi_hub/feature/crop_care/resources/all_seed_store_repository.dart';
import 'package:krishi_hub/feature/crop_care/resources/crop_care_api_provider.dart';
import 'package:krishi_hub/http/api_provider.dart';
import 'package:krishi_hub/common/response/response.dart';

class CropCareRepository {
  final Env env;
  final ApiProvider apiProvider;
  late CropCareApiProvider cropCareApiProvider;
  final AuthRepository authRepository;
  final AllDoctorRecordRepository allDoctorRecordRepository;
  final AllFertilizerStoreRepository allFertilizerStoreRepository;
  final AllSeedstoreRepository allSeedstoreRepository;
  CropCareRepository({
    required this.apiProvider,
    required this.env,
    required this.allSeedstoreRepository,
    required this.allDoctorRecordRepository,
    required this.authRepository,
    required this.allFertilizerStoreRepository,
  }) {
    cropCareApiProvider = CropCareApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      authRepository: authRepository,
      globalUrl: env.globalBaseUrl,
    );
  }

  int _currentPage = 1;
  int _totalPage = 0;
  final List<String> _items = [];

  List<String> get getItems => _items;

  Future<DataResponse<List<String>>> getDoctorRecord({
    bool isLoadMore = false,
    String searchSlug = "",
    String? type,
    String? category,
  }) async {
    List<DoctorRecordModel> temp = [];

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
      final res = await cropCareApiProvider.doctorRecord(
        currentPage: _currentPage,
        searchSlug: searchSlug,
        type: type,
        category: category,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => DoctorRecordModel.fromMap(e))
          .toList();
      _currentPage = res['pagination']?['currentPage'] ?? _currentPage;
      _totalPage = res['pagination']?['totalPages'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allDoctorRecordRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      if (_currentPage == 1 && temp.isNotEmpty) {
        await HiveStorage().setListValues<DoctorRecordModel>(
            HiveStorage().doctorExpertList, temp);
      }

      return DataResponse.success(_items);
    } catch (e) {
      Log.e(e);
      if (isLoadMore) {
        _currentPage--;
      }

      if (_currentPage == 1) {
        temp = await HiveStorage()
            .getListValues<DoctorRecordModel>(HiveStorage().doctorExpertList);
        if (temp.isNotEmpty) {
          _items.clear();
          allDoctorRecordRepository.removeAll();

          for (int i = 0; i < temp.length; i++) {
            allDoctorRecordRepository.addAll({temp[i].id: temp[i]});
            _items.add(temp[i].id);
          }

          return DataResponse.success(_items);
        }
      }
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<String>>> getFertilizerStore(
      {bool isLoadMore = false, String searchSlug = ""}) async {
    List<FertilizerStoreModel> temp = [];

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
      final res = await cropCareApiProvider.fertilizerStore(
        currentPage: _currentPage,
        searchSlug: searchSlug,
        storetype: StoreType.FERTILIZER.name,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => FertilizerStoreModel.fromMap(e))
          .toList();
      _currentPage = res['pagination']?['currentPage'] ?? _currentPage;
      _totalPage = res['pagination']?['totalPages'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allFertilizerStoreRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      // if (_currentPage == 1 && temp.isNotEmpty) {
      //   await HiveStorage().setListValues<FertilizerStoreModel>(
      //       HiveStorage().fertilizerList, temp);
      // }

      return DataResponse.success(_items);
    } catch (e) {
      Log.e(e);
      if (isLoadMore) {
        _currentPage--;
      }

      // if (_currentPage == 1) {
      //   temp = await HiveStorage()
      //       .getListValues<FertilizerStoreModel>(HiveStorage().fertilizerList);
      //   if (temp.isNotEmpty) {
      //     _items.clear();
      //     allFertilizerStoreRepository.removeAll();

      //     for (int i = 0; i < temp.length; i++) {
      //       allFertilizerStoreRepository.addAll({temp[i].id: temp[i]});
      //       _items.add(temp[i].id);
      //     }

      //     return DataResponse.success(_items);
      //   }
      // }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<FertilizerStoreModel>> getFertilizerStoreById(
      {required String id}) async {
    try {
      final res = await cropCareApiProvider.fertilizerStoreById(id: id);

      FertilizerStoreModel temp =
          FertilizerStoreModel.fromMap(res['data']?['data']);

      return DataResponse.success(temp);
    } catch (e) {
      Log.e(e);

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<String>>> getSeedStore(
      {bool isLoadMore = false, String searchSlug = ""}) async {
    List<FertilizerStoreModel> temp = [];

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
      final res = await cropCareApiProvider.fertilizerStore(
        currentPage: _currentPage,
        searchSlug: searchSlug,
        storetype: StoreType.SEED.name,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => FertilizerStoreModel.fromMap(e))
          .toList();
      _currentPage = res['pagination']?['currentPage'] ?? _currentPage;
      _totalPage = res['pagination']?['totalPages'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allSeedstoreRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      if (_currentPage == 1 && temp.isNotEmpty) {
        await HiveStorage()
            .setListValues<FertilizerStoreModel>(HiveStorage().seedList, temp);
      }

      return DataResponse.success(_items);
    } catch (e) {
      Log.e(e);
      if (isLoadMore) {
        _currentPage--;
      }

      if (_currentPage == 1) {
        temp = await HiveStorage()
            .getListValues<FertilizerStoreModel>(HiveStorage().seedList);
        if (temp.isNotEmpty) {
          _items.clear();
          allSeedstoreRepository.removeAll();

          for (int i = 0; i < temp.length; i++) {
            allSeedstoreRepository.addAll({temp[i].id: temp[i]});
            _items.add(temp[i].id);
          }

          return DataResponse.success(_items);
        }
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<DoctorRecordModel>> getDoctorByid(
      {required String id}) async {
    try {
      final res = await cropCareApiProvider.doctorRecordById(id: id);

      DoctorRecordModel temp = DoctorRecordModel.fromMap(res['data']?['data']);

      return DataResponse.success(temp);
    } catch (e) {
      Log.e(e);

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<String>>> getInsuranceDirectory(
      {bool isLoadMore = false, String searchSlug = ""}) async {
    List<DoctorRecordModel> temp = [];

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
      final res = await cropCareApiProvider.insuranceCenterDirectory(
        currentPage: _currentPage,
        searchSlug: searchSlug,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => DoctorRecordModel.fromMap(e))
          .toList();
      _currentPage = res['pagination']?['currentPage'] ?? _currentPage;
      _totalPage = res['pagination']?['totalPages'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allDoctorRecordRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      return DataResponse.success(_items);
    } catch (e) {
      Log.e(e);
      if (isLoadMore) {
        _currentPage--;
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<DoctorRecordModel>> getInsuranceDirectoryId(
      {required String id}) async {
    try {
      final res =
          await cropCareApiProvider.insuranceCenterDirectoryById(id: id);

      DoctorRecordModel temp = DoctorRecordModel.fromMap(res['data']?['data']);

      return DataResponse.success(temp);
    } catch (e) {
      Log.e(e);

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<String>>> getAgricultureEquipement(
      {bool isLoadMore = false, String searchSlug = ""}) async {
    List<DoctorRecordModel> temp = [];

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
      final res = await cropCareApiProvider.agricultureEquipement(
        currentPage: _currentPage,
        searchSlug: searchSlug,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => DoctorRecordModel.fromMap(e))
          .toList();
      _currentPage = res['pagination']?['currentPage'] ?? _currentPage;
      _totalPage = res['pagination']?['totalPages'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allDoctorRecordRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      return DataResponse.success(_items);
    } catch (e) {
      Log.e(e);
      if (isLoadMore) {
        _currentPage--;
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<DoctorRecordModel>> getAgricultureEquipmentDetail(
      {required String id}) async {
    try {
      final res = await cropCareApiProvider.getAgricultureEquipmentByid(id: id);

      DoctorRecordModel temp = DoctorRecordModel.fromMap(res['data']?['data']);

      return DataResponse.success(temp);
    } catch (e) {
      Log.e(e);

      return DataResponse.error(e.toString());
    }
  }
}
