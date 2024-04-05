import 'package:krishi_hub/common/model/multi_language.dart';

class CalenderConstant {
  static const hillyEn = 'Hilly';
  static const teraiEn = 'Terai';
  static const mountainEn = 'Mountain';

  static const hillyNe = 'पहाडी';
  static const teraiNe = 'तराई';
  static const mountainNe = 'पहाड';

  static const harvestingTime = "Harvest Time";
  static const sowingTime = "Sowing Time";
  static const growingTime = "Growing Time";

  static MultiLanguage hilly = MultiLanguage(
    en: hillyEn,
    ne: hillyNe,
  );

  static MultiLanguage terai = MultiLanguage(
    en: teraiEn,
    ne: teraiNe,
  );

  static MultiLanguage mountain = MultiLanguage(
    en: mountainEn,
    ne: mountainNe,
  );

  static List<MultiLanguage> ecologicalAreaList = [
    hilly,
    terai,
    mountain,
  ];
}
