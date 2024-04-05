import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nepali_utils/nepali_utils.dart';

class DateTimeUtils {
  static String formatTimeOfDay(TimeOfDay timeOfDay) {
    final hour = timeOfDay.hour.toString().padLeft(2, '0');
    final minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static String formatTimeInAmPm(String value) {
    try {
      final DateFormat inputFormat = DateFormat('HH:mm');
      final DateFormat outputFormat = DateFormat('hh:mm a');
      final DateTime time = inputFormat.parse(value);

      return outputFormat.format(time);
    } catch (e) {
      debugPrint(e.toString());

      return "";
    }
  }

  static String convertDateIntoTime(String value) {
    DateTime? date = DateTime.tryParse(value);

    if (date != null) {
      final DateFormat outputFormat = DateFormat('hh:mm a');

      return outputFormat.format(date);
    }
    return "";
  }

  static String formatDate(String value) {
    DateTime? date = DateTime.tryParse(value);
    if (date != null) {
      return DateFormat('MMMM d, y').format(date);
    } else {
      return "";
    }
  }

  static String getWeekDayFromDataTime(String value) {
    DateTime? date = DateTime.tryParse(value);
    if (date != null) {
      return DateFormat('EEEE').format(date);
    } else {
      return "";
    }
  }

  static String getChatMesageDate(String value) {
    DateTime? date = DateTime.tryParse(value);

    if (date != null) {
      return DateFormat('MMMM d, hh:mm a').format(date);
    } else {
      return "";
    }
  }

  convertAdIntoBs(String value) {
    DateTime? dateInAd = DateTime.tryParse(value);

    if (dateInAd == null) return "";
    NepaliDateTime dateInNe = dateInAd.toNepaliDateTime();

    

    
  }
}
