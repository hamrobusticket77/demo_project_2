import 'dart:io';

import 'package:krishi_hub/common/model/multi_language.dart';

enum AppEnvironment {
  development,
  production,
  krishihub,
  benighat,
}

class Environment {
  final AppEnvironment appEnvironment;
  final String appTitle;
  final String versionName;
  final String appUpdateDate;

  final String appleStoreId;
  final String appBundleId;
  final String googlePackageName;
  final String googlePlayStore;

  final String appleAppStore;

  final String appLink;

  final MultiLanguage appHomeTitle;
  final MultiLanguage appHomeSubTitle;

  Environment({
    required this.appTitle,
    required this.versionName,
    required this.appUpdateDate,
    required this.appleStoreId,
    required this.appBundleId,
    required this.googlePackageName,
    required this.googlePlayStore,
    required this.appLink,
    required this.appleAppStore,
    required this.appEnvironment,
    required this.appHomeTitle,
    required this.appHomeSubTitle,
  });

  factory Environment.krishihub() {
    return Environment(
      appTitle: "Krishi Portal",
      versionName: "v.1.0.0",
      appUpdateDate: "last updated at: 12th March, 2024",
      appleStoreId: "",
      appBundleId: "",
      googlePackageName: "com.cliffbyte.krishi_hub",
      googlePlayStore:
          "https://play.google.com/store/apps/details?id=com.cliffbyte.krishi_hub",
      appleAppStore: "https://apps.apple.com/app/___/id__",
      appLink: Platform.isAndroid
          ? "https://play.google.com/store/apps/details?id=com.cliffbyte.krishi_hub"
          : "https://apps.apple.com/app/___/id__",
      appEnvironment: AppEnvironment.krishihub,
      appHomeTitle: MultiLanguage(
        en: "Krishi Portal",
        ne: "कृषि पोर्टल",
      ),
      appHomeSubTitle: MultiLanguage(en: "", ne: ""),
    );
  }

  factory Environment.benighat() {
    return Environment(
      appTitle: "Benighat Krishi",
      versionName: "v.1.0.0",
      appUpdateDate: "last updated at: 12th March, 2024",
      appleStoreId: "",
      appBundleId: "",
      googlePackageName: "com.cliffbyte.benighat",
      googlePlayStore:
          "https://play.google.com/store/apps/details?id=com.cliffbyte.benighat",
      appleAppStore: "https://apps.apple.com/app/___/id__",
      appLink: Platform.isAndroid
          ? "https://play.google.com/store/apps/details?id=com.cliffbyte.benighat"
          : "https://apps.apple.com/app/___/id__",
      appEnvironment: AppEnvironment.benighat,
      appHomeTitle: MultiLanguage(
        en: "Benighat Krishi",
        ne: "बेनीघाट कृषि",
      ),
      appHomeSubTitle: MultiLanguage(
        en: "",
        ne: "",
      ),
    );
  }
}
