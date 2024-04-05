import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';

class AcadamyConstant {
  static const literateNe = "साक्षर";
  static const llliterateNe = "निरक्षर";

  static const literateEn = "Literate";
  static const llliterateEn = "Illiterate";

  static List<String> genderEn = [literateNe, llliterateNe];
  static List<String> genderNe = [literateEn, llliterateEn];

  static List<String> get gender {
    if (CheckLocal.isEnglish()) {
      return genderEn;
    }
    return genderNe;
  }

  // static String get getSelectedGender {
  //   if (CheckLocal.isEnglish()) {
  //     return selecteGenderEn;
  //   }
  //   return selecteGenderNe;
  // }

  static String getAcadayInEnglish(String value) {
    if (value == literateNe || value == literateEn) {
      return "Literate";
    } else if (value == llliterateNe || value == llliterateEn) {
      return "Illiterate";
    } else {
      return "";
    }
  }

  static MultiLanguage getAcadamyLocal(String value) {
    switch (value) {
      case literateEn:
      case literateNe:
        return MultiLanguage(en: literateEn, ne: literateNe);

      case literateEn:
      case literateNe:
        return MultiLanguage(en: literateEn, ne: literateNe);
      default:
        return MultiLanguage(en: literateEn, ne: literateNe);
    }
  }
}
