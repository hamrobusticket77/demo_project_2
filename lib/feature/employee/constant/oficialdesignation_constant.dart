import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';

class OfficialDesignationConstant {
  static const mayorNe = "मेयर";
  static const deputyMayorNe = "उपमेयर";
  static const chiefAdmistrativeOfficerNe = "प्रमुख प्रशासकीय अधिकृत";
  static const presidentNe = "राष्ट्रपति";
  static const secretaryNe = "सचिव";
  static const wardMemberNe = "वार्ड सदस्य";

  static const mayorEn = "MAYOR";
  static const deputyMayorEn = "DEPUTY_MAYOR";
  static const chiefAdmistrativeOfficerEn = "CHIEF_ADMINISTRATIVE_OFFICER";
  static const presidentEn = "PRESIDENT";
  static const secretaryEn = "SECRETARY";
  static const wardMemberEn = "WARD MEMBER";

  static const otherEn = "OTHERS";
  static List<String> farmerTypeNe = [
    mayorNe,
    deputyMayorNe,
    chiefAdmistrativeOfficerNe,
    presidentNe,
    secretaryNe,
    wardMemberNe
  ];
  static List<String> farmerTypeEn = [
    mayorEn,
    deputyMayorEn,
    chiefAdmistrativeOfficerEn,
    presidentEn,
    secretaryEn,
    wardMemberEn
  ];

  static List<String> get officeDesignation {
    if (CheckLocal.isEnglish()) {
      return farmerTypeEn;
    }
    return farmerTypeNe;
  }

  static MultiLanguage getOfficeDesignation(String value) {
    switch (value) {
      case mayorNe:
      case mayorEn:
        return MultiLanguage(en: mayorEn, ne: mayorNe);

      case deputyMayorEn:
      case deputyMayorNe:
        return MultiLanguage(en: deputyMayorEn, ne: deputyMayorNe);

      case chiefAdmistrativeOfficerEn:
      case chiefAdmistrativeOfficerNe:
        return MultiLanguage(
            en: chiefAdmistrativeOfficerEn, ne: chiefAdmistrativeOfficerNe);

      case presidentNe:
      case presidentEn:
        return MultiLanguage(en: presidentEn, ne: presidentNe);

      case secretaryEn:
      case secretaryNe:
        return MultiLanguage(en: secretaryEn, ne: secretaryNe);

      case wardMemberEn:
      case wardMemberNe:
        return MultiLanguage(en: wardMemberEn, ne: wardMemberNe);

      default:
        return MultiLanguage(en: otherEn, ne: otherEn);
    }
  }
}
