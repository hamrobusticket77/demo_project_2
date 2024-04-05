import 'package:flutter/material.dart';
import 'package:krishi_hub/common/hive/hive_storage.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/feature/krishi_knowledge/resources/all_agriculture_knowledge_repository.dart';
import 'package:krishi_hub/feature/news/model/news_model.dart';
import 'package:krishi_hub/feature/news/resource/all_reference_content_repository.dart';
import 'package:krishi_hub/feature/refrence_contant/model/reference_content_model.dart';
import '../../../common/constant/env.dart';
import '../../../common/response/response.dart';
import '../../../http/api_provider.dart';
import 'all_news_repository.dart';
import 'news_api_provider.dart';

class NewsRepository {
  final AllNewsRepository allnewsRepository;
  final AllReferenceContentRepository allReferenceContentRepository;
  Env env;

  final ApiProvider apiProvider;

  late NewsApiProvider newsApiProvider;

  NewsRepository({
    required this.env,
    required this.allnewsRepository,
    required this.apiProvider,
    required this.allReferenceContentRepository,
  }) {
    newsApiProvider = NewsApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      globalUrl: env.globalBaseUrl,
    );
  }

  int _currentPage = 1;
  int _totalPage = 0;
  final List<String> _items = [];
  List<String> get getItems => _items;

  Future<DataResponse<List<String>>> getnews({bool isLoadMore = false}) async {
    List<NewsModel> temp = [];

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

      final res = await newsApiProvider.getNews(
        currentPage: _currentPage,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => NewsModel.fromJson(e))
          .toList();
      _currentPage = res['pagination']?['currentPage'] ?? _currentPage;
      _totalPage = res['pagination']?['total'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allnewsRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      if (_currentPage == 1) {
        if (temp.isNotEmpty) {
          await HiveStorage()
              .setListValues<NewsModel>(HiveStorage().newsList, temp);
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
            .getListValues<NewsModel>(HiveStorage().newsList);
        if (temp.isNotEmpty) {
          allnewsRepository.removeAll();

          _items.clear();
          for (int i = 0; i < temp.length; i++) {
            allnewsRepository.addAll({temp[i].id: temp[i]});
            _items.add(temp[i].id);
          }

          return DataResponse.success(_items);
        }
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<NewsModel>>> getScrollableNews() async {
    List<NewsModel> temp = [];

    try {
      final res = await newsApiProvider.getNews(
        currentPage: _currentPage,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => NewsModel.fromJson(e))
          .toList();
      List<NewsModel> value = [];

      for (var v in temp) {
        if (v.isScrolling) {
          value.add(v);
        }
      }

      if (value.isNotEmpty) {
        await HiveStorage()
            .setListValues<NewsModel>(HiveStorage().scrollNews, temp);
      }

      return DataResponse.success(value);
    } catch (e) {
      debugPrint(e.toString());

      temp = await HiveStorage()
          .getListValues<NewsModel>(HiveStorage().scrollNews);
      if (temp.isNotEmpty) {
        return DataResponse.success(temp);
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<ReferenceContentModel>>> getReferenceContent(
      {String searchSlug = ""}) async {
    List<ReferenceContentModel> temp = [];

    try {
      final res = await newsApiProvider.getReferenceContent(
        currentPage: _currentPage,
        search: searchSlug,
      );

      temp = List.from(res['data']?['data']?['data'] ?? []).map((e) {
        return ReferenceContentModel.fromMap(e);
      }).toList();

      _currentPage =
          res['data']?['data']?['pagination']?['currentPage'] ?? _currentPage;
      _totalPage =
          res['data']?['data']?['pagination']?['totalPages'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allReferenceContentRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }
      List<ReferenceContentModel> value = [];

      for (var element in temp) {
        if (element.isPublished) {
          value.add(element);
        }
      }

      return DataResponse.success(temp);
    } catch (e) {
      debugPrint(e.toString());

      if (temp.isNotEmpty) {
        return DataResponse.success(temp);
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<ReferenceContentModel>> getReferenceContentById(
      {required String id}) async {
    try {
      final res = await newsApiProvider.getReferenceById(id: id);

      ReferenceContentModel temp =
          ReferenceContentModel.fromMap(res['data']?['data']);

      return DataResponse.success(temp);
    } catch (e) {
      Log.e(e);

      return DataResponse.error(e.toString());
    }
  }
}
