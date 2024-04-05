import 'package:flutter/material.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/feedback/model/feedback_list_model.dart';
import 'package:krishi_hub/feature/feedback/resource/all_feedback_repository.dart';
import 'package:krishi_hub/feature/feedback/resource/feedback_api_provider.dart';
import 'package:krishi_hub/http/api_provider.dart';
import 'package:krishi_hub/common/response/response.dart';

class FeedbackRepository {
  final Env env;
  final ApiProvider apiProvider;
  late FeedbackApiProvider feedbackApiProvider;
  final AuthRepository authRepository;
  final AllFeedbackRepository allFeedbackRepository;

  FeedbackRepository({
    required this.apiProvider,
    required this.env,
    required this.authRepository,
    required this.allFeedbackRepository,
  }) {
    feedbackApiProvider = FeedbackApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      authRepository: authRepository,
    );
  }

  Future<DataResponse<bool>> deleteFeedback({required String id}) async {
    try {
      await feedbackApiProvider.deleteFeedback(id: id);

      return DataResponse.success(true);
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> createFeedback({
    required String name,
    required String email,
    required String phoneNumber,
    required String title,
    required String description,
  }) async {
    try {
      Map<String, dynamic> body = {
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "title": title,
        "description": description,
      };

      final res = await feedbackApiProvider.sendfeedback(body: body);

      return DataResponse.success(true);
    } catch (e) {
      debugPrint(e.toString());

      return DataResponse.error(e.toString());
    }
  }

  int _currentPage = 1;
  int _totalPage = 0;
  final List<String> _items = [];
  List<String> get getItems => _items;

  Future<DataResponse<List<String>>> getfedbacklist(
      {bool isLoadMore = false}) async {
    List<FeedbackListModel> temp = [];

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

      final res = await feedbackApiProvider.getfeedbacklist(
        currentPage: _currentPage,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => FeedbackListModel.fromJson(e))
          .toList();
      _currentPage = res['pagination']?['currentPages'] ?? _currentPage;
      _totalPage = res['pagination']?['total'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allFeedbackRepository.addAll({temp[i].id: temp[i]});
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
