import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/hive/hive_storage.dart';
import 'package:krishi_hub/common/model/photos.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/media/resource/media_repository.dart';
import 'package:krishi_hub/feature/product/model/product_model.dart';
import 'package:krishi_hub/feature/product/resource/all_product_repository.dart';
import 'package:krishi_hub/feature/product/resource/product_api_provider.dart';
import 'package:krishi_hub/http/api_provider.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/market_price/model/product_model.dart'
    as product;

class ProductRepository {
  final Env env;
  final ApiProvider apiProvider;
  late ProductApiProvider productApiProvider;
  final AuthRepository authRepository;
  final MediaRepository mediaRepository;

  final AllProductRepository allProductRepository;

  ProductRepository({
    required this.apiProvider,
    required this.env,
    required this.authRepository,
    required this.allProductRepository,
    required this.mediaRepository,
  }) {
    productApiProvider = ProductApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      authRepository: authRepository,
      globalBaseUrl: env.globalBaseUrl,
    );
  }

  int _currentPage = 1;
  int _totalPage = 0;
  final List<String> _items = [];
  List<String> get getItems => _items;

  Future<DataResponse<List<String>>> getProduct(
      {bool isLoadMore = false, String searchSlug = ""}) async {
    List<ProductModel> temp = [];

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

      final res = await productApiProvider.getProduct(
        currentPage: _currentPage,
        searchSlug: searchSlug,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => ProductModel.fromMap(e))
          .toList();
      _currentPage = res['pagination']?['currentPage'] ?? _currentPage;
      _totalPage = res['pagination']?['totalPages'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allProductRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      if (_currentPage == 1 && temp.isNotEmpty) {
        await HiveStorage()
            .setListValues<ProductModel>(HiveStorage().productList, temp);
      }

      return DataResponse.success(_items);
    } catch (e) {
      Log.e(e);
      if (isLoadMore) {
        _currentPage--;
      }

      if (_currentPage == 1) {
        temp = await HiveStorage()
            .setListValues<ProductModel>(HiveStorage().productList, temp);
        if (temp.isNotEmpty) {
          _items.clear();
          allProductRepository.removeAll();

          for (int i = 0; i < temp.length; i++) {
            allProductRepository.addAll({temp[i].id: temp[i]});
            _items.add(temp[i].id);
          }

          return DataResponse.success(_items);
        }
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> createProduct({
    required String productionDate,
    required int estimatedPricePerUnit,
    required int quantity,
    required String unit,
    required String description,
    required int category,
    required int title,
    required List<File> media,
  }) async {
    try {
      Map<String, dynamic> body = {
        "productionDate": productionDate,
        "estimatedPriceperunit": estimatedPricePerUnit,
        "quantity": quantity,
        "unit": unit,
        "category": category.toString(),
        "title": title.toString()
      };

      if (description.isNotEmpty) {
        body['description'] = description;
      }

      if (media.isNotEmpty) {
        String m = "";

        m = await mediaRepository.mediaUpload(
          file: media,
          relatedTo: "PRODUCT",
        );

        body['media'] = m;
      }

      final res = await productApiProvider.createProduct(body: body);

      return DataResponse.success(true);
    } catch (e) {
      Log.e(e);

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> updateProduct({
    required String productId,
    required String productionDate,
    required int estimatedPricePerUnit,
    required int quantity,
    required String unit,
    required String description,
    required int category,
    required int title,
    required List<File> media,
    required List<Photos> deletedMedia,
    required int? mediaId,
  }) async {
    try {
      Map<String, dynamic> body = {
        "id": productId,
        "productionDate": productionDate,
        "estimatedPriceperunit": estimatedPricePerUnit,
        "quantity": quantity,
        "unit": unit,
        "description": description,
        "category": category.toString(),
        "title": title.toString()
      };

      if (description.isNotEmpty) {
        body['description'] = description;
      }
      var _mediaId;

      if (mediaId == null) {
        if (media.isNotEmpty) {
          _mediaId = await mediaRepository.mediaUpload(
              file: media, relatedTo: "PRODUCT");
        }
      } else {
        _mediaId = await mediaRepository.mediaUpdate(
            file: media,
            deletedMedia: deletedMedia.map((e) => e.id).toList(),
            mediaId: mediaId,
            relatedTo: "PRODUCT");
      }

      if (mediaId != null) {
        body['media'] = _mediaId;
      }

      if (media.isNotEmpty) {
        body['media'] = _mediaId;
      }

      final res = await productApiProvider.updateProduct(body: body);

      return DataResponse.success(true);
    } catch (e) {
      Log.e(e);

      return DataResponse.error(e.toString());
    }
  }

  // Uri uri = Uri.parse("$baseUrl/agriculture-plan/program-form/$id");

  Future<DataResponse<bool>> deleteProduct({required String id}) async {
    try {
      await productApiProvider.deleteProduct(id);

      return DataResponse.success(true);
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<product.ProductModel>>> getProductCategoryList(
      String type) async {
    List<product.ProductModel> temp = [];

    try {
      final res = await productApiProvider.getProductCategoryList(type);
      temp = List.from(res['data']?['data'] ?? [])
          .map((e) => product.ProductModel.fromMap(e))
          .toList();

      return DataResponse.success(temp);
    } catch (e) {
      if (kDebugMode) {
        Log.e(e);
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<product.ProductModel>>> getProductByCategoryType(
      String type) async {
    List<product.ProductModel> temp = [];

    try {
      final res = await productApiProvider.getProductByCategoryType(type);
      temp = List.from(res['data']?['data'] ?? [])
          .map((e) => product.ProductModel.fromMap(e))
          .toList();

      return DataResponse.success(temp);
    } catch (e) {
      if (kDebugMode) {
        Log.e(e);
      }

      return DataResponse.error(e.toString());
    }
  }

  // Future<DataResponse<List<MarketModel>>> getMarketList() async {
  //   List<MarketModel> temp = [];

  //   try {
  //     final res = await marketPriceApiProvider.getMarketList();
  //     temp = List.from(res['data']?['data'] ?? [])
  //         .map((e) => MarketModel.fromMap(e))
  //         .toList();

  //     return DataResponse.success(temp);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       Log.e(e);
  //     }

  //     return DataResponse.error(e.toString());
  //   }
  // }
}
