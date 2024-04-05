import 'package:flutter/material.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'app/theme.dart';

class CommonCardWrapper extends StatelessWidget {
  final double? elevation;
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? contentPadding;
  final Function()? onTap;
  final double? borderRadius;
  final Color? backgroundColor;
  final bool hasShadow;
  const CommonCardWrapper({
    super.key,
    required this.child,
    this.onTap,
    this.elevation,
    this.margin,
    this.backgroundColor,
    this.contentPadding,
    this.borderRadius,
    this.hasShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 10.wp),
        boxShadow: [
          if (hasShadow)
            const BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 2,
                spreadRadius: 2,
                color: CustomTheme.lightGray),
        ],
      ),
      margin: margin ??
          EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding.wp, vertical: 10.hp),
      child: Material(
        elevation: elevation ?? 0.1,
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
              padding: contentPadding ?? EdgeInsets.all(15.wp),
              decoration: BoxDecoration(
                color: backgroundColor ??
                    Theme.of(context).primaryColor.withOpacity(0.04),
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
              child: child),
        ),
      ),
    );
  }
}
