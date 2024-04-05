import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';

class LiteratureConstant {
  static const testPassNe = "कक्षा १० (टेष्टपास)";
  static const slcne = "एस.एल.सी./एस.ई.ई.";
  static const plusTwone = "१० जोड २ वा सो सरह";
  static const graduationne = "स्नातक वा सो सरह)";
  static const masterDegreene = "स्नातकोत्तर वा सो सरह";
  static const noLevelne = "तह नभएको नखुलेको";
  static const masterDegree = "स्नातकोत्तर वा सो सरह";
  static const othereducationne = "अन्य";

  static const testPassEn = "Class 10 (Test pass)";
  static const slcEn = "S.L.C./S.E.E.";
  static const plusTwoneEN = "plusTwo";
  static const graduationneEn = "Graduation";
  static const masterDegreeneEn = "Master Degree";
  static const noLevelneEn = "No Level";
  static const othereducationneEn = "Others-education";

  static List<String> literatureNe = [
    testPassNe,
    slcne,
    plusTwone,
    graduationne,
    masterDegreene,
    noLevelne,
    othereducationne
  ];
  static List<String> literatureEn = [
    testPassEn,
    slcEn,
    plusTwoneEN,
    graduationneEn,
    masterDegreeneEn,
    noLevelneEn,
    othereducationneEn,
  ];

  static List<String> get gender {
    if (CheckLocal.isEnglish()) {
      return literatureEn;
    }
    return literatureNe;
  }

  // static String get getSelectedGender {
  //   if (CheckLocal.isEnglish()) {
  //     return selecteGenderEn;
  //   }
  //   return selecteGenderNe;
  // }

  static String getLiterature(String value) {
    if (value == testPassNe || value == testPassEn) {
      return "Class 10 (Test pass)";
    } else if (value == slcne || value == slcEn) {
      return "S.L.C./S.E.E.";
    } else if (value == plusTwone || value == plusTwoneEN) {
      return "plusTwo";
    } else if (value == graduationne || value == graduationneEn) {
      return "Graduation";
    } else if (value == masterDegreene || value == masterDegreeneEn) {
      return "Master Degree";
    } else if (value == noLevelne || value == noLevelneEn) {
      return "No Level";
    } else if (value == othereducationne || value == othereducationneEn) {
      return "Others-education";
    } else {
      return "";
    }
  }

  static MultiLanguage getLitratureLocal(String value) {
    switch (value) {
      case testPassNe:
      case testPassEn:
        return MultiLanguage(en: testPassNe, ne: testPassEn);

      case slcne:
      case slcEn:
        return MultiLanguage(en: slcEn, ne: slcne);

      case plusTwoneEN:
      case plusTwone:
        return MultiLanguage(en: plusTwoneEN, ne: plusTwone);

      case graduationne:
      case graduationneEn:
        return MultiLanguage(en: graduationneEn, ne: graduationne);

      case masterDegreene:
      case masterDegreeneEn:
        return MultiLanguage(en: masterDegreeneEn, ne: masterDegreene);

      case noLevelne:
      case noLevelneEn:
        return MultiLanguage(en: noLevelneEn, ne: noLevelne);

      default:
        return MultiLanguage(en: othereducationneEn, ne: othereducationne);
    }
  }
}
