import 'package:flutter/material.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';

import '../../../../common/app/theme.dart';
import '../../../../common/common_svg_widget.dart';
import '../../../../common/widget/button/custom_icon_button.dart';

class RoundedListTileCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onPressed;
  final bool hasForwardIcon;
  final double borderRadius;
  final double horizontalPadding;
  final double vertialPadding;
  final FontWeight titleFontWeight;
  final double? titleFontSize;

  const RoundedListTileCard(
      {super.key,
      required this.title,
      required this.icon,
      this.onPressed,
      this.borderRadius = 25,
      this.horizontalPadding = 20,
      this.vertialPadding = 10,
      this.hasForwardIcon = true,
      this.titleFontWeight = FontWeight.w500,
      this.titleFontSize});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.hp),
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
                color: CustomTheme.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(borderRadius.wp)),
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding.wp, vertical: vertialPadding.hp),
            child: Row(
              children: [
                CustomIconButton(
                  icon: icon,
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.5),
                  iconColor: CustomTheme.white,
                  horizontalPadding: 8,
                  verticalPadding: 8,
                  iconSize: 16,
                ),
                SizedBox(width: 20.wp),
                Expanded(
                    child: Text(
                  title,
                  style: textTheme.bodyLarge!.copyWith(
                    fontWeight: titleFontWeight,
                    fontSize: titleFontSize,
                  ),
                )),
                if (hasForwardIcon)
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                    color: Theme.of(context).primaryColor,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedListTileCardNew extends StatelessWidget {
  final String title;
  final String iconPath;
  final Function()? onPressed;
  final bool hasForwardIcon;
  final double borderRadius;
  final double horizontalPadding;
  final double vertialPadding;
  final FontWeight titleFontWeight;
  final double? titleFontSize;

  const RoundedListTileCardNew({
    super.key,
    required this.title,
    required this.iconPath,
    this.onPressed,
    this.borderRadius = 0,
    this.horizontalPadding = 28,
    this.vertialPadding = 12,
    this.hasForwardIcon = true,
    this.titleFontWeight = FontWeight.w500,
    this.titleFontSize = 15,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.hp),
      child: Material(
        elevation: 0,
        color: CustomTheme.white,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
                color: CustomTheme.grey.withOpacity(0.08),
                borderRadius: BorderRadius.circular(borderRadius.wp)),
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding.wp, vertical: vertialPadding.hp),
            child: Row(
              children: [
                CommonSvgWidget(
                  svgName: iconPath,
                  height: 20,
                  width: 20,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 20.wp),
                Expanded(
                    child: Text(
                  title,
                  style: textTheme.headlineSmall!.copyWith(
                    fontWeight: titleFontWeight,
                    fontSize: titleFontSize,
                  ),
                )),
                if (hasForwardIcon)
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 17,
                    color: CustomTheme.grey,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
