import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/feature/market_price/model/current_market_price_model.dart';
import 'package:krishi_hub/feature/market_price/model/market_model.dart';
import 'package:krishi_hub/feature/market_price/model/market_price_model.dart';
import 'package:krishi_hub/feature/market_price/model/product_model.dart'
    as product;

import 'package:krishi_hub/feature/market_price/resources/all_current_market_price_repository.dart';
import 'package:krishi_hub/feature/market_price/resources/all_market_price_repository.dart';
import 'package:krishi_hub/feature/market_price/resources/market_price_api_provider.dart';
import '../../../common/constant/env.dart';
import '../../../common/response/response.dart';
import '../../../http/api_provider.dart';

class MarketPriceRepository {
  Env env;

  final ApiProvider apiProvider;

  late MarketPriceApiProvider marketPriceApiProvider;
  final AllCurrentMarketPriceRepository allCurrentMarketPriceRepository;
  final AllMarketPriceRepository allMarketPriceRepository;
  MarketPriceRepository({
    required this.env,
    required this.apiProvider,
    required this.allCurrentMarketPriceRepository,
    required this.allMarketPriceRepository,
  }) {
    marketPriceApiProvider = MarketPriceApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      globalBaseUrl: env.globalBaseUrl,
    );
  }
  int _currentPage = 1;
  int _totalPage = 0;
  final List<String> _items = [];
  List<String> get getItems => _items;

  Future<DataResponse<List<List<String>>>> getMarketPrices() async {
    List<List<String>> data = [];

    try {
      final res = await marketPriceApiProvider.getMarketPrice(
        currentPage: _currentPage,
      );
      List<List<String>> data = [];
      final temp = List.from(res['data']?["data"]?['data'] ?? []);

      for (var value in temp) {
        List<dynamic> v = value;

        List<String> m = List.from(v).map((e) => e.toString()).toList();

        data.add(m);
      }

      return DataResponse.success(data);
    } catch (e) {
      debugPrint(e.toString());

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<String>>> getWholesalerRate({
    bool isLoadMore = false,
    String searchSlug = "",
    String? type,
    String? category,
    String? product,
  }) async {
    List<CurrentMarketPriceModel> temp = [];

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

      final res = await marketPriceApiProvider.getWholesalerRate(
        currentPage: _currentPage,
        searchSlug: searchSlug,
        type: type,
        category: category,
        product: product,
      );
      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => CurrentMarketPriceModel.fromMap(e))
          .toList();

      for (int i = 0; i < temp.length; i++) {
        allCurrentMarketPriceRepository
            .addAll({temp[i].id.toString(): temp[i]});
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

  Future<DataResponse<List<String>>> getMarketPriceNew({
    String? searchSlug,
    String? marketId,
    String? type,
    String? category,
    String? product,
    bool isLoadMore = false,
  }) async {
    List<MarketPriceModel> temp = [];

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

      final res = await marketPriceApiProvider.getMarketPrice(
        currentPage: _currentPage,
        search: searchSlug,
        marketId: marketId,
        type: type,
        category: category,
        product: product,
      );
      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => MarketPriceModel.fromMap(e))
          .toList();

      for (int i = 0; i < temp.length; i++) {
        allMarketPriceRepository.addAll({temp[i].id.toString(): temp[i]});
        _items.add(temp[i].id.toString());
      }

      _currentPage =
          res['data']?['data']?['pagination']?['currentPage'] ?? _currentPage;
      _totalPage =
          res['data']?['data']?['pagination']?['currentPage'] ?? _totalPage;

      return DataResponse.success(_items);
    } catch (e) {
      debugPrint(e.toString());
      if (isLoadMore) {
        _currentPage--;
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<MarketModel>>> getMarketList() async {
    List<MarketModel> temp = [];

    try {
      final res = await marketPriceApiProvider.getMarketList();
      temp = List.from(res['data']?['data'] ?? [])
          .map((e) => MarketModel.fromMap(e))
          .toList();

      return DataResponse.success(temp);
    } catch (e) {
      if (kDebugMode) {
        Log.e(e);
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<CurrentMarketPriceModel>> getCurrentMarketPriceDetail(
      {required String id}) async {
    try {
      final res = await marketPriceApiProvider.getCurrentMarkerDetail(id: id);

      CurrentMarketPriceModel temp =
          CurrentMarketPriceModel.fromMap(res['data']?['data']);

      return DataResponse.success(temp);
    } catch (e) {
      Log.e(e);

      return DataResponse.error(e.toString());
    }
  }
}
