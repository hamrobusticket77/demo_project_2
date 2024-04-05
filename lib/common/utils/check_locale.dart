import 'package:flutter/material.dart';
import 'package:krishi_hub/common/constant/custom_locale.dart';
import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';

class CheckLocal {
  static isEnglish() {
    bool isEnglishLocale = Localizations.localeOf(NavigationService.context) ==
        CustomLocale.english;

    return isEnglishLocale;
  }

  static String check(MultiLanguage value) {
    bool isEnglishLocale = Localizations.localeOf(NavigationService.context) ==
        CustomLocale.english;
    if (isEnglishLocale) {
      return value.en ?? "";
    } else {
      return value.ne ?? "";
    }
  }
}
