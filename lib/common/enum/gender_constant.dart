import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';

class GenderConstant {
  static const selecteGenderNe = "लिङ्ग चयन गर्नुहोस";
  static const maleNe = "पुरुष";
  static const femaleNe = "महिला";
  static const otherNe = "अन्य";

  static const selecteGenderEn = "Select Gender";
  static const maleEn = "MALE";
  static const femaleEn = "FEMALE";
  static const otherEn = "OTHERS";

  static List<String> genderNe = [maleNe, femaleNe, otherNe];
  static List<String> genderEn = [maleEn, femaleEn, otherEn];

  static List<String> get gender {
    if (CheckLocal.isEnglish()) {
      return genderEn;
    }
    return genderNe;
  }

  static String get getSelectedGender {
    if (CheckLocal.isEnglish()) {
      return selecteGenderEn;
    }
    return selecteGenderNe;
  }

  static String getGenderInEnglish(String value) {
    if (value == selecteGenderNe || value == selecteGenderEn) {
      return "Select Gender";
    } else if (value == maleNe || value == maleEn) {
      return "MALE";
    } else if (value == femaleNe || value == femaleEn) {
      return "FEMALE";
    } else if (value == otherNe || value == otherEn) {
      return "OTHERS";
    } else {
      return "";
    }
  }

  static MultiLanguage getGenderLocal(String value) {
    switch (value) {
      case maleEn:
      case maleNe:
        return MultiLanguage(en: maleEn, ne: maleNe);

      case femaleEn:
      case femaleNe:
        return MultiLanguage(en: femaleEn, ne: femaleNe);

      case otherEn:
      case otherNe:
        return MultiLanguage(en: otherEn, ne: otherNe);

      default:
        return MultiLanguage(en: otherEn, ne: otherNe);
    }
  }
}
