import 'package:flutter/material.dart';
import 'package:krishi_hub/common/hive/hive_storage.dart';
import 'package:krishi_hub/feature/images/model/image_album_model.dart';
import 'package:krishi_hub/feature/images/model/images_model.dart';
import 'package:krishi_hub/feature/images/resources/all_images_repository.dart';
import 'package:krishi_hub/feature/images/resources/images_api_provider.dart';
import '../../../common/constant/env.dart';
import '../../../common/response/response.dart';
import '../../../http/api_provider.dart';

class ImagesRepository {
  final AllImagesRepository allimagesRepository;
  Env env;

  final ApiProvider apiProvider;

  late ImagesApiProvider imagesApiProvider;

  ImagesRepository({
    required this.env,
    required this.allimagesRepository,
    required this.apiProvider,
  }) {
    imagesApiProvider =
        ImagesApiProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  int _currentPage = 1;
  int _totalPage = 0;
  final List<int> _items = [];
  List<int> get getItems => _items;

  Future<DataResponse<List<int>>> getAlbum({bool isLoadMore = false}) async {
    List<ImageAlbumModel> temp = [];

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

      final res = await imagesApiProvider.getAlbum(
        currentPage: _currentPage,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => ImageAlbumModel.fromMap(e))
          .toList();
      _currentPage = res['pagination']?['currentPages'] ?? _currentPage;
      _totalPage = res['pagination']?['total'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allimagesRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      if (_currentPage == 1 && temp.isNotEmpty) {
        await HiveStorage()
            .setListValues<ImageAlbumModel>(HiveStorage().imageAlbum, temp);
      }

      return DataResponse.success(_items);
    } catch (e) {
      debugPrint(e.toString());
      if (isLoadMore) {
        _currentPage--;
      }

      if (_currentPage == 1) {
        temp = await HiveStorage()
            .getListValues<ImageAlbumModel>(HiveStorage().imageAlbum);
        if (temp.isNotEmpty) {
          for (int i = 0; i < temp.length; i++) {
            allimagesRepository.addAll({temp[i].id: temp[i]});
            _items.add(temp[i].id);
          }

          return DataResponse.success(_items);
        }
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<ImagesModel>>> getImage(int id) async {
    List<ImagesModel> temp = [];

    try {
      final res = await imagesApiProvider.getImage(id);

      temp = List.from(res['data']?['data'] ?? [])
          .map((e) => ImagesModel.fromMap(e))
          .toList();

      return DataResponse.success(temp);
    } catch (e) {
      debugPrint(e.toString());

      return DataResponse.error(e.toString());
    }
  }
}
