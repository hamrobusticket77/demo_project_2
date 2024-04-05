import 'package:krishi_hub/common/model/multi_language.dart';

class KnowledgetTypeModel {
  final MultiLanguage appbarTitle;
  final String type;
  KnowledgetTypeModel({
    required this.appbarTitle,
    required this.type,
  });

  factory KnowledgetTypeModel.animalHusbandary() {
    return KnowledgetTypeModel(
      appbarTitle:
          MultiLanguage(en: "Animal Husbandry Knowledge", ne: "पशुपालन ज्ञान"),
      type: "livelihood",
    );
  }

  factory KnowledgetTypeModel.crop() {
    return KnowledgetTypeModel(
      appbarTitle: MultiLanguage(en: "Crop Knowledge", ne: "बाली ज्ञान"),
      type: "crop",
    );
  }

  factory KnowledgetTypeModel.disease() {
    return KnowledgetTypeModel(
      appbarTitle: MultiLanguage(en: "Disease Worm", ne: "रोग कीरा"),
      type: "disease",
    );
  }
}
