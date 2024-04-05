import 'package:flutter/material.dart';
import 'package:krishi_hub/common/model/multi_language.dart';

class FeedbackStatus {
  static const newen = "New";
  static const ongoing = "चलिरहेको";
  static const rejected = "REJECTED";
  static const appoved = "APPOVED";

  static const newne = "नयाँ";
  static const ongoingne = "अनलाइन";
  static const rejectedne = "अस्वीकार गरियो";
  static const appovedne = "स्वीकृत";

  static List<MultiLanguage> feedbackStatusList = [
    MultiLanguage(en: newen, ne: newne),
    MultiLanguage(en: ongoing, ne: ongoingne),
    MultiLanguage(en: rejected, ne: rejectedne),
    MultiLanguage(en: appoved, ne: appovedne)
  ];

  static MultiLanguage getFeedbackStatus(value) {
    switch (value) {
      case newen:
      case newne:
        return feedbackStatusList[0];
      
      case newen:
      case newne:
        return feedbackStatusList[1];

      case ongoing:
      case ongoingne:
        return feedbackStatusList[2];
      case rejected:
      case rejectedne:
        return feedbackStatusList[3];
      case appoved:
      case appovedne:
        return feedbackStatusList[4];
      default:
        return feedbackStatusList[0];
    }
  }

  static Color getFeedbackStatusColor(value) {
    switch (value) {
      case newen:
      case newne:
        return Colors.grey;

      case ongoing:
      case ongoingne:
        return Colors.green;

      case rejected:
      case rejectedne:
        return Colors.yellow;
      case appoved:
      case appovedne:
        return Colors.blue;

      default:
        return Colors.grey;
    }
  }
}
