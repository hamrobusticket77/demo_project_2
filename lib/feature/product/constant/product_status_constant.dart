import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';

class ProductStatusConstant {
  static const newNe = "नयाँ";
  static const ongoingNe = "जारी छ";
  static const rejectedNe = "अस्वीकार गरियो";
  static const approvedNe = "स्वीकृत";

  static const newEn = "NEW";
  static const ongoingEn = "ONGOING";
  static const rejectedEn = "REJECTED";
  static const approvedEn = "APPROVED";
  static const otherEn = "OTHERS";
  static List<String> c = [newNe, ongoingNe, rejectedNe, approvedNe];
  static List<String> productStatusEn = [
    newEn,
    ongoingEn,
    rejectedEn,
    approvedEn
  ];

  static List<String> get productStatus {
    if (CheckLocal.isEnglish()) {
      return productStatusEn;
    }
    return productStatusEn;
  }

  static String getProductStatu(String value) {
    if (value == newNe || value == newEn) {
      return "New";
    } else if (value == ongoingNe || value == ongoingEn) {
      return "ONGOING";
    } else if (value == rejectedNe || value == rejectedEn) {
      return "REJECTED";
    } else if (value == approvedNe || value == approvedEn) {
      return "APPROVED";
    } else {
      return "";
    }
  }

  static MultiLanguage getProductStatus(String value) {
    switch (value) {
      case newNe:
      case newEn:
        return MultiLanguage(en: newEn, ne: newNe);

      case ongoingEn:
      case ongoingNe:
        return MultiLanguage(en: ongoingEn, ne: ongoingNe);

      case rejectedEn:
      case rejectedNe:
        return MultiLanguage(en: rejectedEn, ne: rejectedNe);
      case approvedEn:
      case approvedNe:
        return MultiLanguage(en: approvedEn, ne: approvedNe);
      default:
        return MultiLanguage(en: otherEn, ne: approvedNe);
    }
  }
}
