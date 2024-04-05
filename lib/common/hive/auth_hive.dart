import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthHive {
  static const userresource = "user_resource";
  // static const accessToken = "accessToken";
  // static const refreshToken = "refreshToken";
  // static const userData = "userData";
  static const phoneData = "remember_me";
  static const language = "language";
  static const deviceConfig = "deviceConfig";
  static const appVersion = "appVersion";

  static final AuthHive _hiveServices = AuthHive._internal();

  factory AuthHive() {
    return _hiveServices;
  }

  AuthHive._internal();

  init() async {
    await Hive.initFlutter();
  }


  Future<void> setRemember(String user) async {
    final box = await Hive.openBox(userresource);
    await box.put(phoneData, user);
    // await box.close();
  }

  Future<String?> getRemember() async {
    try {
      final box = await Hive.openBox(userresource);
      final data = box.get(phoneData);
      // await box.close();
      if (data == null) {
        return data;
      }

      return data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> removeRemember() async {
    final box = await Hive.openBox(userresource);
    await box.delete(phoneData);
    await box.close();
  }

  Future<void> setLanguage(String user) async {
    final box = await Hive.openBox(userresource);
    await box.put(language, user);
    // await box.close();
  }

  Future<String?> getLanguage() async {
    try {
      final box = await Hive.openBox(userresource);
      final data = box.get(language);
      // await box.close();
      if (data == null) {
        return data;
      }

      return data;
    } catch (e) {
      print(e.toString());
      return "en";
    }
  }

  void saveEmailData(String phone) async {
    final box = await Hive.openBox(userresource);
    await box.put(phoneData, phone);
    // await box.close();
  }

  Future<String> getSavedEmailData() async {
    try {
      final box = await Hive.openBox(userresource);
      final data = box.get(phoneData);
      // await box.close();
      if (data == null) {
        return data as String;
      }

      return data as String;
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  setDeviceConfig() async {
    final box = await Hive.openBox(userresource);
    await box.put(deviceConfig, "true");
    // await box.close();
  }

  Future<bool> getDeviceConfig() async {
    try {
      final box = await Hive.openBox(userresource);
      final data = box.get(deviceConfig);
      // await box.close();
      if (data == null) {
        return false;
      }

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> setAppVersion(String version) async {
    final box = await Hive.openBox(userresource);
    await box.put(appVersion, version);
  }

  Future<String> getAppVersion() async {
    try {
      final box = await Hive.openBox(userresource);
      final data = box.get(appVersion);

      if (data == null) {
        return "";
      }

      return data;
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }
}
