import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';

class CustomRoundedButton extends StatefulWidget {
  const CustomRoundedButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.isDisabled = false,
      this.isLoading = false,
      this.padding,
      this.color,
      this.horizontalPadding = 12,
      this.verticalPadding = 13,
      this.fontSize = 14,
      this.textColor = CustomTheme.white,
      this.fontWeight = FontWeight.w400,
      this.horizontalMargin = 0,
      this.icon,
      this.iconsize = 22,
      this.borderRadius = 8,
      this.elevation = 5,
      this.prefixIcon,
      this.outlineColor,
      this.iconColor})
      : super(key: key);
  final String title;
  final Function()? onPressed;
  final bool isDisabled;
  final bool isLoading;
  final Color? color;
  final EdgeInsets? padding;
  final double horizontalPadding;
  final double verticalPadding;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final double horizontalMargin;
  final IconData? icon;
  final double borderRadius;
  final double iconsize;
  final double elevation;
  final Widget? prefixIcon;
  final Color? outlineColor;
  final Color? iconColor;

  @override
  CustomRoundedButtonState createState() => CustomRoundedButtonState();
}

class CustomRoundedButtonState extends State<CustomRoundedButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalMargin),
      child: Material(
        elevation: widget.elevation,
        color: widget.isDisabled
            ? CustomTheme.white
            : (widget.color ?? theme.primaryColor),
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: InkWell(
          onTap: widget.isDisabled ? null : widget.onPressed,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Container(
            padding: widget.padding ??
                EdgeInsets.symmetric(
                  vertical: widget.verticalPadding,
                  horizontal: widget.horizontalPadding,
                ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: widget.isDisabled
                  ? null
                  : Border.all(
                      color: widget.outlineColor ??
                          widget.color ??
                          theme.primaryColor,
                    ),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.prefixIcon != null)
                    Row(
                      children: [
                        widget.prefixIcon!,
                        SizedBox(
                          width: 2.hp,
                        )
                      ],
                    ),
                  Text(
                    widget.title,
                    style: theme.textTheme.headlineSmall!.copyWith(
                      fontWeight: widget.fontWeight,
                      color: widget.isDisabled
                          ? CustomTheme.black
                          : widget.textColor,
                      fontSize: widget.fontSize,
                    ),
                  ),
                  if (widget.icon != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.wp),
                      child: Icon(
                        widget.icon,
                        color: widget.iconColor ?? CustomTheme.white,
                        size: widget.iconsize,
                      ),
                    ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeOut,
                    child: widget.isLoading
                        ? Container(
                            height: 14,
                            width: 14,
                            margin: const EdgeInsets.only(left: 8),
                            child: const CircularProgressIndicator(
                              color: CustomTheme.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
