import 'dart:io';

import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/hive/auth_hive.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/common/secure_storage/secure_storage.dart';
import 'package:krishi_hub/common/utils/device_info_utils.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/feature/auth/model/user_model.dart';
import 'package:krishi_hub/feature/auth/resource/auth_api_provider.dart';
import 'package:krishi_hub/http/api_provider.dart';

class AuthRepository {
  final Env env;
  final ApiProvider apiProvider;
  late AuthApiProvider authApiProvider;

  AuthRepository({
    required this.apiProvider,
    required this.env,
  }) {
    authApiProvider = AuthApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
    );
  }

  String _accessToken = '';

  String _refreshToken = "";

  String get accessToken => _accessToken;

  String get refreshToken => _refreshToken;

  final ValueNotifier<bool> _isLoggedIn = ValueNotifier(false);

  ValueNotifier<bool> get isLoggedIn => _isLoggedIn;

  final ValueNotifier<UserModel?> _user = ValueNotifier(null);

  ValueNotifier<UserModel?> get user => _user;

  final ValueNotifier<String?> _rememberUserId = ValueNotifier(null);
  ValueNotifier<String?> get rememberUserId => _rememberUserId;

  // String? get userId => user.value?.id;

  Future initial() async {
    await fetchAccessToken();
    await fetchRefreshToken();
    // await DeviceInfoUtils.setAppVersion();

    _user.value = await SecureStorage().getUser();

    await fetchRememberMe();
  }

  Future setAccessToken(String token) async {
    try {
      await SecureStorage().setAccessToken(token);
      _isLoggedIn.value = true;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future setRefreshToken(String refreshToken) async {
    try {
      await SecureStorage().setRefreshToken(refreshToken);
      // _isLoggedIn.value = true;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> fetchAccessToken() async {
    try {
      final token = await SecureStorage().getAccessToken();
      if (token != null && token != "") {
        _accessToken = token;
        _isLoggedIn.value = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return "";
  }

  Future<String> fetchRefreshToken() async {
    try {
      final refreshToken = await SecureStorage().getRefreshToken();
      if (refreshToken != null && refreshToken != "") {
        _refreshToken = refreshToken;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return refreshToken;
  }

  Future fetchRememberMe() async {
    try {
      _rememberUserId.value = await AuthHive().getRemember() ?? "";
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<DataResponse<bool>> login(
      {required String phoneNumber,
      required String password,
      required bool isRememberMe}) async {
    try {
      if (isRememberMe) {
        _rememberUserId.value = phoneNumber;
        await AuthHive().setRemember(phoneNumber);
      } else {
        await AuthHive().removeRemember();
      }

      final fcm = await getFirebaseMessagingToken();

      final deviceId = await DeviceInfoUtils.getDeviceId();
      Map<String, String> body = {
        "phoneNumber": phoneNumber,
        "password": password,
        "fcm": fcm,
        "deviceId": deviceId,
        "platform": Platform.isAndroid ? "android" : "ios",
      };

      final res = await authApiProvider.login(body: body);

      _accessToken = res['data']?['data']?['tokens']?['accessToken'] ?? "";

      _user.value = UserModel.fromMap(res['data']?['data']?['admin']
              ?['farmerDetails']?["farmerPersonalInformation"] ??
          {});

      await _getUserDetails();
      await SecureStorage().setUser(user: _user.value!);
      await setAccessToken(_accessToken);
      _isLoggedIn.value = true;
      return DataResponse.success(true);
    } catch (e) {
      _accessToken = '';
      _refreshToken = '';
      _isLoggedIn.value = false;
      debugPrint(e.toString());
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      Map<String, String> body = {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      };

      final res =
          await authApiProvider.updatePassword(body: body, token: _accessToken);

      return DataResponse.success(true);
    } catch (e) {
      debugPrint(e.toString());
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse> logout() async {
    try {
      final deviceId = await DeviceInfoUtils.getDeviceId();

      Map<String, String> body = {
        "deviceId": deviceId,
        "platform": Platform.isAndroid ? "android" : "ios",
      };
      await authApiProvider.logout(body: body, token: _accessToken);
      await SecureStorage().removeAccessToken();
      await SecureStorage().removeRefreshToken();
      await SecureStorage().removeUser();
      await fetchRememberMe();

      _isLoggedIn.value = false;
      _user.value = null;

      _accessToken = "";

      return DataResponse.success(true);
    } catch (e) {
      Log.e(e);
      await SecureStorage().removeAccessToken();
      await SecureStorage().removeRefreshToken();
      await SecureStorage().removeUser();
      await fetchRememberMe();

      _isLoggedIn.value = false;
      _user.value = null;

      _accessToken = "";

      return DataResponse.success(true);
    }
  }

  Future localLogout() async {
    try {
      await SecureStorage().removeAccessToken();
      await SecureStorage().removeRefreshToken();
      await SecureStorage().removeUser();
      await fetchRememberMe();

      _isLoggedIn.value = false;
      _user.value = null;

      _accessToken = "";
    } catch (e) {
      Log.e(e);
      await SecureStorage().removeAccessToken();
      await SecureStorage().removeRefreshToken();
      await SecureStorage().removeUser();
      await fetchRememberMe();

      _isLoggedIn.value = false;
      _user.value = null;

      _accessToken = "";

      return DataResponse.success(true);
    }
  }

  Future<DataResponse<bool>> farmerRequest(
      {required String fullName,
      required String phoneNumber,
      required int wardNumber}) async {
    try {
      final body = <String, dynamic>{
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "wardNo": wardNumber
      };

      await authApiProvider.farmerRequest(body);

      return DataResponse.success(true);
    } catch (e) {
      Log.e(e);

      return DataResponse.error(e.toString());
    }
  }

  Future _getUserDetails() async {
    try {
      final res = await authApiProvider.getUserDetails(_accessToken);

      Log.d(res);

      _user.value = UserModel.fromMap(
          res['data']?['data']?['data']?['farmerPersonalInformation'] ?? {});

      // Log.d(userModel.toMap());
    } catch (e) {
      Log.e(e);
    }
  }

  Future<String> getFirebaseMessagingToken() async {
    String firebaseAppToken = '';
    if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
      try {
        firebaseAppToken =
            await AwesomeNotificationsFcm().requestFirebaseAppToken();
        debugPrint(firebaseAppToken);
      } catch (exception) {
        debugPrint('$exception');
      }
    } else {
      debugPrint('Firebase is not available on this project');
    }
    return firebaseAppToken;
  }

  Future<DataResponse<bool>> deleteUser({
    required String phoneNumber,
    required String password,
    required String reasonToDelete,
  }) async {
    try {
      final res = await authApiProvider.deleteUser(
        phoneNumber: phoneNumber,
        password: password,
        reasonToDelete: reasonToDelete,
        accessToken: accessToken,
        userId: _user.value?.id ?? "",
      );

      return DataResponse.success(true);
    } catch (e) {
      if (kDebugMode) {
        Log.e(e);
      }
      return DataResponse.error(e.toString());
    }
  }
}
