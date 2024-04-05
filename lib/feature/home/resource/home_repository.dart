// import 'package:flutter/material.dart';
// import 'package:metro_appointment_user/common/constant/env.dart';
// import 'package:metro_appointment_user/common/http/api_provider.dart';
// import 'package:metro_appointment_user/common/http/response.dart';
// import 'package:metro_appointment_user/feature/auth/resource/auth_repository.dart';
// import 'package:metro_appointment_user/feature/home/model/admin_status_model.dart';
// import 'package:metro_appointment_user/feature/home/resource/home_api_provider.dart';

import 'dart:io';

import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/hive/auth_hive.dart';
import 'package:krishi_hub/common/utils/device_info_utils.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/feature/home/resource/home_api_provider.dart';
import 'package:krishi_hub/http/api_provider.dart';

class HomeRepository {
  final ApiProvider apiProvider;
  final Env env;

  late HomeApiProvider homeApiProvider;

  // final AuthRepositorye authRepository;

  HomeRepository({
    required this.apiProvider,
    required this.env,
  }) {
    homeApiProvider = HomeApiProvider(
      apiProvider: apiProvider,
      baseUrl: env.baseUrl,
    );
  }

  Future deviceConfig() async {
    try {
      if (!await AuthHive().getDeviceConfig()) {
        final fcm = await getFirebaseMessagingToken();

        final deviceId = await DeviceInfoUtils.getDeviceId();

        final body = <String, dynamic>{
          "fcm": fcm,
          "deviceId": deviceId,
          "platform": Platform.isAndroid ? "android" : "ios",
        };
        await homeApiProvider.deviceConfig(body);
        await AuthHive().setDeviceConfig();
      }
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
        debugPrint(exception.toString());
      }
    } else {
      debugPrint('Firebase is not available on this project');
    }
    return firebaseAppToken;
  }

  // Future<DataResponse<AdminStatusModel>> getAdminStatus() async {
  //   try {

  //   } catch (e) {

  //   }
  // }
}
