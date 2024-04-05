import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';

class CropUtils {
  static getColor(TabController? controller, int index) {
    return controller?.index == index
        ? ColorFilter.mode(
            Theme.of(NavigationService.context).primaryColor, BlendMode.srcIn)
        : const ColorFilter.mode(CustomTheme.grey, BlendMode.srcIn);
  }
}
