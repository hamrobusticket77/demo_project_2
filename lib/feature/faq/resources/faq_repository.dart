import 'package:flutter/material.dart';
import 'package:krishi_hub/feature/faq/model/faq_model.dart';
import 'package:krishi_hub/feature/faq/resources/all_faq_repository.dart';
import 'package:krishi_hub/feature/faq/resources/faq_api_provider.dart';
import '../../../common/constant/env.dart';
import '../../../common/response/response.dart';
import '../../../http/api_provider.dart';

class FAQRepository {
  final AllFaqRepository allfaqRepository;
  Env env;

  final ApiProvider apiProvider;

  late FaqApiProvider faqApiProvider;

  FAQRepository({
    required this.env,
    required this.allfaqRepository,
    required this.apiProvider,
  }) {
    faqApiProvider =
        FaqApiProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  int _currentPage = 1;
  int _totalPage = 0;
  final List<String> _items = [];
  List<String> get getItems => _items;

  Future<DataResponse<List<String>>> getfaq({bool isLoadMore = false}) async {
    List<FAQModel> temp = [];

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

      final res = await faqApiProvider.getFaq(
        currentPage: _currentPage,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => FAQModel.fromJson(e))
          .toList();
      _currentPage = res['pagination']?['currentPages'] ?? _currentPage;
      _totalPage = res['pagination']?['total'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allfaqRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
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
