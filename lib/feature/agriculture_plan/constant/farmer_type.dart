import 'package:krishi_hub/common/model/multi_language.dart';

class GroupType {
  static const groupEn = "Group";
  static const individualEn = "Individual";

  static const groupeNe = "समूह";
  static const individualNe = "व्यक्तिगत";

  static List<MultiLanguage> groupTypeList = [
    MultiLanguage(en: groupEn, ne: groupeNe),
    MultiLanguage(en: individualEn, ne: individualNe),
  ];

  static MultiLanguage getFarmerMultiLang(String value) {
    switch (value) {
      case groupEn:
      case groupeNe:
        return groupTypeList[0];
      case individualEn:
      case individualNe:
        return groupTypeList[1];

      default:
        return groupTypeList[0];
    }
  }
}
