import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:krishi_hub/common/app/theme.dart';

class CustomToast {
  static success(
      {required String message, Toast? length, ToastGravity? gravity}) {
    cancelToast();
    Fluttertoast.showToast(
      msg: message,
      gravity: gravity ?? ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      toastLength: length ?? Toast.LENGTH_LONG,
    );
  }

  static error(
      {required String message, Toast? length, ToastGravity? gravity}) {
    cancelToast();
    Fluttertoast.showToast(
      msg: message,
      gravity: gravity ?? ToastGravity.BOTTOM,
      backgroundColor: CustomTheme.red,
      toastLength: length ?? Toast.LENGTH_LONG,
    );
  }

  static cancelToast() {
    Fluttertoast.cancel();
  }
}
