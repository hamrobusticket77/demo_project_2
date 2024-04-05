import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';

class BottomSheetWrapper extends StatelessWidget {
  final EdgeInsets? padding;
  final double? topPadding;
  final Widget child;
  const BottomSheetWrapper({
    super.key,
    this.padding,
    this.topPadding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Container(
      padding: padding ??
          EdgeInsets.only(
            left: CustomTheme.symmetricHozPadding.wp,
            right: CustomTheme.symmetricHozPadding.wp,
            top: 24.hp,
            bottom: 24.hp,
          ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: _theme.scaffoldBackgroundColor,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.hp),
            child,
          ],
        ),
      ),
    );
  }
}
