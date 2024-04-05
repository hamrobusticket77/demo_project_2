import 'package:flutter/material.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/common/utils/internet_checker.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/notification/model/notification_model.dart';
import 'package:krishi_hub/feature/notification/resource/all_notification_repository.dart';
import 'package:krishi_hub/feature/notification/resource/notification_api_provider.dart';
import 'package:krishi_hub/http/api_provider.dart';

class NotificationRepository {
  final InternetCheck internetCheck;

  final AuthRepository authRepository;
  final Env env;
  late NotificationApiProvider notificationApiProvider;

  final AllNotificationRepository allNotificationRepository;

  final ApiProvider apiProvider;
  NotificationRepository({
    required this.internetCheck,
    required this.authRepository,
    required this.env,
    required this.apiProvider,
    required this.allNotificationRepository,
  }) {
    notificationApiProvider = NotificationApiProvider(
      apiProvider: apiProvider,
      baseUrl: env.baseUrl,
      authRepository: authRepository,
    );
  }

  bool _appOpenedFromNotification = false;

  bool get appOpenNotification => _appOpenedFromNotification;

  setAppOpenNotification(value) {
    _appOpenedFromNotification = value;
  }

  int _currentPage = 1;
  int _totalPage = 0;
  final List<String> _items = [];
  List<String> get getItems => _items;

  Future<DataResponse<List<String>>> getNotificaiton(
      {bool isLoadMore = false}) async {
    List<NotificationCardModel> temp = [];
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

      final res = await notificationApiProvider.getNotifications(
        currentPage: _currentPage,
      );

      temp = List.from(res['data']?['data']?['data'] ?? {})
          .map((e) => NotificationCardModel.fromMap(e))
          .toList();

      for (var value in temp) {
        _items.add(value.id);
        allNotificationRepository.addAll({value.id: value});
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

  Future<DataResponse<bool>> updateNotification({required String id}) async {
    try {
      final res = await notificationApiProvider.updateNotification(id: id);
      allNotificationRepository.updated(id);

      return DataResponse.success(true);
    } catch (e) {
      debugPrint(e.toString());

      return DataResponse.error(e.toString());
    }
  }
  // subribeToDefaultNotications() {}

  // unSubribeToDefaultNotications() {}

  //   Future<String> getFirebaseMessagingToken() async {
  //   String firebaseAppToken = '';
  //   if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
  //     try {
  //       firebaseAppToken =
  //           await AwesomeNotificationsFcm().requestFirebaseAppToken();
  //       debugPrint(firebaseAppToken);
  //     } catch (exception) {
  //       debugPrint('$exception');
  //     }
  //   } else {
  //     debugPrint('Firebase is not available on this project');
  //   }
  //   return firebaseAppToken;
  // }
}
