import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/constant/custom_locale.dart';

class LocalWrapper extends StatefulWidget {
  final Widget _child;

  const LocalWrapper({super.key, required Widget child}) : _child = child;

  @override
  State<LocalWrapper> createState() => _LocalWrapperState();
}

class _LocalWrapperState extends State<LocalWrapper> {
  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      useOnlyLangCode: true,
      supportedLocales: const [
        CustomLocale.english,
        CustomLocale.nepali,
      ],
      fallbackLocale: CustomLocale.nepali,
      path: "assets/translations",
      saveLocale: true,
      startLocale: CustomLocale.fallBackLocal,
      child: widget._child,
    );
  }
}
