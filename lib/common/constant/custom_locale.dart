import 'package:flutter/widgets.dart';
import 'package:krishi_hub/common/hive/auth_hive.dart';

class CustomLocale {
  static const english = Locale("en", "US");
  static const nepali = Locale("ne", "ne_NP");

  static Locale fallBackLocal = nepali;

  static getFallBackLocal() async {
    final lang = await AuthHive().getLanguage();
    if (lang == "en") {
      fallBackLocal = english;
    } else {
      fallBackLocal = nepali;
    }
  }
}
