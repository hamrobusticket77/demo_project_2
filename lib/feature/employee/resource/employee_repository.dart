import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/hive/hive_storage.dart';
import 'package:krishi_hub/feature/employee/model/elective_representative_model.dart';
import 'package:krishi_hub/feature/employee/model/employee_model.dart';
import 'package:krishi_hub/feature/employee/resource/all_electiverepresentive_repository.dart';
import 'package:krishi_hub/feature/employee/resource/employee_api_provider.dart';

import '../../../common/constant/env.dart';
import '../../../common/response/response.dart';
import '../../../http/api_provider.dart';
import 'all_employee_repository.dart';

class EmployeeRepository {
  final AllEmployeeRepository allEmployeeRepository;
  AllElectiveRepresentiveRepository allElectiveRepresentiveRepository;
  Env env;

  final ApiProvider apiProvider;

  late EmployeeApiProvider employeeApiProvider;

  EmployeeRepository({
    required this.env,
    required this.allEmployeeRepository,
    required this.apiProvider,
    required this.allElectiveRepresentiveRepository,
  }) {
    employeeApiProvider =
        EmployeeApiProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  int _currentPage = 1;
  int _totalPage = 0;
  final List<String> _items = [];
  List<String> get getItems => _items;

  Future<DataResponse<List<String>>> getemployee(
      {bool isLoadMore = false}) async {
    List<EmployeeModel> temp = [];

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

      final res = await employeeApiProvider.getemployeelist(
        currentPage: _currentPage,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => EmployeeModel.fromMap(e))
          .toList();

      _currentPage = res['pagination']?['currentPages'] ?? _currentPage;
      _totalPage = res['pagination']?['total'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allEmployeeRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      if (_currentPage == 1 && temp.isNotEmpty) {
        await HiveStorage()
            .setListValues<EmployeeModel>(HiveStorage().employeeList, temp);
      }

      return DataResponse.success(_items);
    } catch (e) {
      debugPrint(e.toString());
      if (isLoadMore) {
        _currentPage--;
      }

      if (_currentPage == 1) {
        temp = await HiveStorage()
            .getListValues<EmployeeModel>(HiveStorage().employeeList);
        if (temp.isNotEmpty) {
          _items.clear();
          allEmployeeRepository.removeAll();

          for (int i = 0; i < temp.length; i++) {
            allEmployeeRepository.addAll({temp[i].id: temp[i]});
            _items.add(temp[i].id);
          }

          return DataResponse.success(_items);
        }
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<String>>> getelectiverepresentive(
      {bool isLoadMore = false}) async {
    List<ElectiveRepresentiveModel> temp = [];

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

      final res = await employeeApiProvider.getelectiverepresentivelist(
        currentPage: _currentPage,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => ElectiveRepresentiveModel.fromMap(e))
          .toList();
      // temp = List.from(res['data']?['data']?['data']??[]).map((e) => ElectiveRepresentiveModel.fromJson(e)).toList();
      _currentPage = res['pagination']?['currentPages'] ?? _currentPage;
      _totalPage = res['pagination']?['total'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allElectiveRepresentiveRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      if (_currentPage == 1 && temp.isNotEmpty) {
        await HiveStorage().setListValues<ElectiveRepresentiveModel>(
            HiveStorage().officialList, temp);
      }

      return DataResponse.success(_items);
    } catch (e) {
      debugPrint(e.toString());
      if (isLoadMore) {
        _currentPage--;
      }

      if (_currentPage == 1) {
        temp = await HiveStorage().getListValues<ElectiveRepresentiveModel>(
            HiveStorage().officialList);
        if (temp.isNotEmpty) {
          _items.clear();
          allElectiveRepresentiveRepository.removeAll();

          for (int i = 0; i < temp.length; i++) {
            allElectiveRepresentiveRepository.addAll({temp[i].id: temp[i]});
            _items.add(temp[i].id);
          }

          return DataResponse.success(_items);
        }
      }

      return DataResponse.error(e.toString());
    }
  }
}
