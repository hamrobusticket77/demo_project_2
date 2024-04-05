import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_svg_widget.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;
  final double borderRadius;
  final Color backgroundColor;
  final Color iconColor;
  final double verticalPadding;
  final double horizontalPadding;
  final double iconSize;
  final bool shadow;
  final bool hasBorderOutline;
  final double outlineBorderWidth;
  const CustomIconButton(
      {Key? key,
      required this.icon,
      this.onPressed,
      this.borderRadius = 45,
      this.backgroundColor = CustomTheme.lightGray,
      this.iconColor = CustomTheme.black,
      this.horizontalPadding = 8,
      this.verticalPadding = 8,
      this.iconSize = 20,
      this.shadow = true,
      this.hasBorderOutline = false,
      this.outlineBorderWidth = 2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      elevation: 0,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onPressed,
        // splashColor: backgroundColor.withOpacity(1),
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: const EdgeInsets.all(3),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: hasBorderOutline
                  ? (horizontalPadding - 5)
                  : horizontalPadding,
              vertical:
                  hasBorderOutline ? (verticalPadding - 5) : verticalPadding,
            ),
            decoration: BoxDecoration(
              border: hasBorderOutline
                  ? Border.all(width: outlineBorderWidth, color: iconColor)
                  : null,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
