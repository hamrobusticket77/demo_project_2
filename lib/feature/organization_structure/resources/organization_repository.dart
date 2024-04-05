import 'package:flutter/material.dart';
import 'package:krishi_hub/feature/organization_structure/resources/all_organzation_repository.dart';
import 'package:krishi_hub/feature/organization_structure/resources/organization_str_api_provider.dart';
import '../../../common/constant/env.dart';
import '../../../common/response/response.dart';
import '../../../http/api_provider.dart';
import '../model/organization_model.dart';

class OrganizationRepository {
  final AllOrginazationRepository allorganizationRepository;
  Env env;

  final ApiProvider apiProvider;

  late OrganizationApiProvider organizationApiProvider;

  OrganizationRepository({
    required this.env,
    required this.allorganizationRepository,
    required this.apiProvider,
  }) {
    organizationApiProvider =
        OrganizationApiProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  int _currentPage = 1;
  int _totalPage = 0;
  final List<String> _items = [];
  List<String> get getItems => _items;

  Future<DataResponse<List<String>>> getnews({bool isLoadMore = false}) async {
    List<OrganizationStructureModel> temp = [];

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

      final res = await organizationApiProvider.getOrganization(
        currentPage: _currentPage,
      );

      temp = List.from(res['data']?['data'] ?? [])
          .map((e) => OrganizationStructureModel.fromMap(e))
          .toList();
      _currentPage = res['pagination']?['currentPages'] ?? _currentPage;
      _totalPage = res['pagination']?['total'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allorganizationRepository.addAll({temp[i].id.toString(): temp[i]});
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
}
