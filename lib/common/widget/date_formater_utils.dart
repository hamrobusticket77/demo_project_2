import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:nepali_utils/nepali_utils.dart';

class DateFormatterUtils {
  static String getFormatedDateInStringEn(
    String? date,
  ) {
    if (date == null || date.isEmpty) {
      return "";
    }

    DateTime? dateTime;

    dateTime = DateTime.tryParse(date);

    if (dateTime != null) {
      return DateFormat('MMMM d, y').format(dateTime);
    } else {
      dateTime =
          DateTime.fromMillisecondsSinceEpoch(int.tryParse(date) ?? 0 * 1000);

      return DateFormat('MMMM d, y').format(dateTime);
    }
  }

  static String getFormatedDateInStringNe(
    String? date,
  ) {
    if (date == null || date.isEmpty) {
      return "";
    }

    NepaliDateTime? dateTime;

    dateTime = NepaliDateTime.tryParse(date);

    if (dateTime != null) {
      return NepaliDateFormat('MMMM d, y').format(dateTime);
    } else {
      return "";
    }
  }

  static convertAdIntoBs(String value) {
    final NepaliDateFormat formatter = NepaliDateFormat('MMMM d, y');

    final temp = DateTime.tryParse(value);
    if (temp != null) {
      return formatter.format(temp.toNepaliDateTime());
    }
    return "";
  }

  static String convertAdIntoBsString(String value) {
    try {
      final NepaliDateFormat formatter = NepaliDateFormat('y/MM/dd');

      final temp = DateTime.tryParse(value);
      if (temp != null) {
        final value = formatter.format(temp.toNepaliDateTime());

        return value.toNepali();
      }
      return "";
    } catch (e) {
      if (kDebugMode) {
        Log.e(e);
      }
      return value;
    }
  }
}
