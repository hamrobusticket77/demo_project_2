import 'dart:async';

import 'package:flutter/material.dart';

class SearchUtils {
  Timer? timer;
  search(VoidCallback action) {
    if (timer != null && timer!.isActive) {
      timer?.cancel();
    }

    timer = Timer(const Duration(milliseconds: 350), action);
  }
}
