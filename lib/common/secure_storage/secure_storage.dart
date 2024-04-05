import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:krishi_hub/common/utils/custom_toast.dart';
import 'package:krishi_hub/feature/auth/model/user_model.dart';

class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();

  factory SecureStorage() {
    return _instance;
  }

  SecureStorage._internal();

  static const String accessToken = "accessToken";
  static const String refreshToken = "refreshToken";

  static const String userData = "userData";

  static final FlutterSecureStorage _flutterSecureStorage =
      FlutterSecureStorage(
    aOptions: Platform.isAndroid
        ? const AndroidOptions(
            encryptedSharedPreferences: true,
          )
        : AndroidOptions.defaultOptions,
  );

  Future<void> setAccessToken(String value) async {
    try {
      await _flutterSecureStorage.write(key: accessToken, value: value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> getAccessToken() async {
    try {
      return await _flutterSecureStorage.read(key: accessToken) ?? "";
    } catch (e) {
      debugPrint(
        e.toString(),
      );
      return "";
    }
  }

  Future<void> removeAccessToken() async {
    try {
      await _flutterSecureStorage.delete(key: accessToken);
    } catch (e) {
      debugPrint(e.toString());
      CustomToast.error(message: e.toString());
    }
  }

  Future<void> setRefreshToken(String value) async {
    try {
      await _flutterSecureStorage.write(
          key: SecureStorage.refreshToken, value: value);
    } catch (e) {
      debugPrint(e.toString());
      CustomToast.error(message: e.toString());
    }
  }

  Future<String> getRefreshToken() async {
    try {
      return await _flutterSecureStorage.read(
              key: SecureStorage.refreshToken) ??
          "";
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  Future<void> removeRefreshToken() async {
    try {
      await _flutterSecureStorage.delete(key: SecureStorage.refreshToken);
    } catch (e) {
      debugPrint(e.toString());
      CustomToast.error(message: e.toString());
    }
  }

  Future<void> setUser({required UserModel user}) async {
    await _flutterSecureStorage.write(
        key: userData, value: jsonEncode(user.toMap()));
  }

  Future<UserModel?> getUser() async {
    try {
      final data = await _flutterSecureStorage.read(key: userData);
      //await box.close();
      if (data == null || data.isEmpty) {
        return null;
      }
      UserModel user = UserModel.fromMap(jsonDecode(data));
      return user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> removeUser() async {
    await _flutterSecureStorage.delete(key: userData);
    //await box.close();
  }
}
