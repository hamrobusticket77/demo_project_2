import 'dart:io' show Platform;

import 'package:flutter/material.dart';

class PlatformUtils {
  static bool isAndroid() {
    try {
      if (Platform.isAndroid) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return true;
  }
}
