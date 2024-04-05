import 'package:flutter/material.dart';
import 'package:krishi_hub/common/hive/hive_storage.dart';
import 'package:krishi_hub/feature/video/resource/video_api_provider.dart';
import '../../../common/constant/env.dart';
import '../../../common/response/response.dart';
import '../../../http/api_provider.dart';
import '../model/video_model.dart';
import 'all_video_repository.dart';

class VideoRepository {
  final AllVideoRepository allvideoRepository;
  Env env;

  final ApiProvider apiProvider;

  late VideoApiProvider videoApiProvider;

  VideoRepository({
    required this.env,
    required this.allvideoRepository,
    required this.apiProvider,
  }) {
    videoApiProvider =
        VideoApiProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  int _currentPage = 1;
  int _totalPage = 0;
  final List<String> _items = [];
  List<String> get getItems => _items;

  Future<DataResponse<List<String>>> getvideo({bool isLoadMore = false}) async {
    List<VideoModel> temp = [];

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

      final res = await videoApiProvider.getvideo(
        currentPage: _currentPage,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => VideoModel.fromMap(e))
          .toList();
      _currentPage = res['pagination']?['currentPages'] ?? _currentPage;
      _totalPage = res['pagination']?['total'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allvideoRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      if (_currentPage == 1) {
        if (temp.isNotEmpty) {
          await HiveStorage()
              .setListValues<VideoModel>(HiveStorage().videoList, temp);
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
            .getListValues<VideoModel>(HiveStorage().videoList);
        if (temp.isNotEmpty) {
          for (int i = 0; i < temp.length; i++) {
            allvideoRepository.addAll({temp[i].id: temp[i]});
            _items.add(temp[i].id);
          }

          return DataResponse.success(_items);
        }
      }

      return DataResponse.error(e.toString());
    }
  }
}
