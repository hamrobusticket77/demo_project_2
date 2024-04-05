import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/hive/hive_storage.dart';
import 'package:krishi_hub/feature/downloads/models/downloads_model.dart';
import 'package:krishi_hub/feature/downloads/resources/all_download_repository.dart';
import 'package:krishi_hub/feature/downloads/resources/download_api_provider.dart';

import '../../../common/constant/env.dart';
import '../../../common/response/response.dart';
import '../../../http/api_provider.dart';

class DownloadRepository {
  final AllDownloadRepository allDownloadRepository;
  Env env;

  final ApiProvider apiProvider;

  late DownloadApiProvider downloadApiProvider;

  DownloadRepository({
    required this.env,
    required this.allDownloadRepository,
    required this.apiProvider,
  }) {
    downloadApiProvider =
        DownloadApiProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  int _currentPage = 1;
  int _totalPage = 0;
  final List<String> _items = [];
  List<String> get getItems => _items;

  Future<DataResponse<List<String>>> getdownloadpdf(
      {bool isLoadMore = false}) async {
    List<DownloadsModel> temp = [];

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

      final res = await downloadApiProvider.getdownloadpdf(
        currentPage: _currentPage,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => DownloadsModel.fromJson(e))
          .toList();

      _currentPage = res['pagination']?['currentPages'] ?? _currentPage;
      _totalPage = res['pagination']?['total'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allDownloadRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      if (_currentPage == 1 && temp.isNotEmpty) {
        await HiveStorage()
            .setListValues<DownloadsModel>(HiveStorage().downloadList, temp);
      }

      return DataResponse.success(_items);
    } catch (e) {
      debugPrint(e.toString());
      if (isLoadMore) {
        _currentPage--;
      }

      if (_currentPage == 1) {
        temp = await HiveStorage()
            .getListValues<DownloadsModel>(HiveStorage().downloadList);
        if (temp.isNotEmpty) {
          _items.clear();
          allDownloadRepository.removeAll();

          for (int i = 0; i < temp.length; i++) {
            allDownloadRepository.addAll({temp[i].id: temp[i]});
            _items.add(temp[i].id);
          }

          return DataResponse.success(_items);
        }
      }

      return DataResponse.error(e.toString());
    }
  }
}
