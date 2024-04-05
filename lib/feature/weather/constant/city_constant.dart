import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';

class CityConstant {
  static const ktmNe = "काठमाडौं";
  static const benighatNe = "बेनीघाट";
  static const pokharaNe = "पोखरा";
  static const otherNe = "अन्य";

  static const ktmEn = "Kathmandu";
  static const benighatEn = "Benighat";
  static const pokharaEn = "Pokhara";
  static const otherEn = "OTHERS";

  static List<String> cityNe = [ktmNe, benighatNe, pokharaNe];
  static List<String> cityEn = [ktmEn, benighatEn, pokharaEn];

  static List<String> get city {
    if (CheckLocal.isEnglish()) {
      return cityEn;
    }
    return cityNe;
  }

  static String getCityEnglish(String value) {
    if (value == ktmNe || value == ktmEn) {
      return "Kathmandu";
    } else if (value == benighatNe || value == benighatEn) {
      return "Benighat";
    } else if (value == pokharaNe || value == pokharaEn) {
      return "Pokhara";
    } else {
      return "";
    }
  }

  static MultiLanguage getCityLocal(String value) {
    switch (value) {
      case ktmEn:
      case ktmNe:
        return MultiLanguage(en: ktmEn, ne: ktmNe);

      case benighatEn:
      case benighatNe:
        return MultiLanguage(en: benighatEn, ne: benighatNe);

      case pokharaEn:
      case pokharaNe:
        return MultiLanguage(en: pokharaEn, ne: pokharaNe);

      default:
        return MultiLanguage(en: otherEn, ne: otherNe);
    }
  }
}
