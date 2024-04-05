import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';

class FullNameUtils {
  static String getFullName(
      {required MultiLanguage firstName,
      MultiLanguage? middleName,
      required MultiLanguage lastName}) {
    String englishName = "";
    String nepaliName = "";

    nepaliName = (middleName != null &&
            middleName.ne != null &&
            middleName.ne!.isNotEmpty)
        ? "${firstName.ne ?? ""} ${middleName.ne ?? ""} ${lastName.ne ?? ""}"
        : "${firstName.ne ?? ""} ${lastName.ne ?? ""}";
    englishName = (middleName != null &&
            middleName.en != null &&
            middleName.en!.isNotEmpty)
        ? "${firstName.en} ${middleName.en ?? ""} ${lastName.en}"
        : "${firstName.en} ${lastName.en}";
    if (CheckLocal.isEnglish()) {
      return englishName.capitalize();
    } else {
      if (nepaliName.trim().isNotEmpty) {
        return nepaliName;
      }
    }
    return englishName.capitalize();
  }

  static String getFullNameOnly(
      {required String firstName,
      String? middleName,
      required String lastName}) {
    String fullName = "";

    fullName = (middleName != null && middleName.isNotEmpty)
        ? "${firstName} ${middleName} ${lastName}"
        : "${firstName} ${lastName}";

    return fullName.capitalize();
  }
}
