import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/hive/hive_storage.dart';

import 'package:krishi_hub/feature/slider/model/slider_model.dart';
import 'package:krishi_hub/feature/slider/resource/all_slider_repository.dart';
import 'package:krishi_hub/feature/slider/resource/slider_api_provider.dart';
import '../../../common/constant/env.dart';
import '../../../common/response/response.dart';
import '../../../http/api_provider.dart';

class SliderRepository {
  final AllSliderRepository allsliderRepository;
  Env env;

  final ApiProvider apiProvider;

  late SliderApiProvider sliderApiProvider;

  SliderRepository({
    required this.env,
    required this.allsliderRepository,
    required this.apiProvider,
  }) {
    sliderApiProvider =
        SliderApiProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  int _currentPage = 1;
  final int _totalPage = 0;
  final List<String> _items = [];
  List<String> get getItems => _items;

  Future<DataResponse<List<SliderModel>>> getslider(
      {bool isLoadMore = false}) async {
    List<SliderModel> temp = [];

    try {
      final res = await sliderApiProvider.getSlider(
        currentPage: _currentPage,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => SliderModel.fromMap(e))
          .toList();

      if (temp.isNotEmpty) {
        await HiveStorage()
            .setListValues<SliderModel>(HiveStorage().sliderImage, temp);
      }

      return DataResponse.success(temp);
    } catch (e) {
      debugPrint(e.toString());
      if (isLoadMore) {
        _currentPage--;
      }

      temp = await HiveStorage()
          .getListValues<SliderModel>(HiveStorage().sliderImage);
      if (temp.isNotEmpty) {
        return DataResponse.success(temp);
      }

      return DataResponse.error(e.toString());
    }
  }
}
