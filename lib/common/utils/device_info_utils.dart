import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:krishi_hub/common/hive/auth_hive.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfoUtils {
  static Future<int?> getSdkVersion() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final info = await deviceInfo.androidInfo;
    return info.version.sdkInt;
  }

  static Future<String> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor ?? ""; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    } else {
      return "";
    }
  }

  static Future<String> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    debugPrint(packageInfo.version);
    packageInfo.buildNumber;
    return packageInfo.version;
  }

  static Future<bool> isAppUpdate() async {
    final currentVersion = await getAppVersion();
    final oldVersion = await AuthHive().getAppVersion();

    if (oldVersion == currentVersion) {
      return false;
    }
    return true;
  }

  static Future<void> setAppVersion() async {
    final currentVersion = await getAppVersion();

    await AuthHive().setAppVersion(currentVersion);
  }
}
