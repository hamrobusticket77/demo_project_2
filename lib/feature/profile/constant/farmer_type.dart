import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';

class FarmerType {
  static const smallNe = "साना किसान";
  static const mediumNe = "मध्यम किसान";
  static const largeNe = "ठूलो";

  static const smallEn = "SmallFarmer";
  static const mediumEn = "MediumFarmer";
  static const largeEn = "ठूलो किसान";

  static const otherEn = "OTHERS";
  static List<String> farmerTypeNe = [smallNe, mediumNe, largeNe];
  static List<String> farmerTypeEn = [smallEn, mediumEn, largeEn];

  static List<String> get productStatus {
    if (CheckLocal.isEnglish()) {
      return farmerTypeEn;
    }
    return farmerTypeNe;
  }

  static MultiLanguage getFarmerType(String value) {
    switch (value) {
      case smallNe:
      case smallEn:
        return MultiLanguage(en: smallEn, ne: smallNe);

      case mediumEn:
      case mediumNe:
        return MultiLanguage(en: mediumEn, ne: mediumNe);

      case largeEn:
      case largeNe:
        return MultiLanguage(en: largeEn, ne: largeNe);

      default:
        return MultiLanguage(en: otherEn, ne: otherEn);
    }
  }
}
