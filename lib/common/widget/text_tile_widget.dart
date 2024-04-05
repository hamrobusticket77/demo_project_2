import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';

class TextTileWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool hasBottomDivider;
  final double bottomPadding;
  final Function()? onTapSubTitle;
  const TextTileWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.hasBottomDivider = true,
    this.bottomPadding = 10,
    this.onTapSubTitle,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                // flex: 4,
                child: Text(
                  "$title:",
                  style: textTheme.titleLarge!.copyWith(
                      color: CustomTheme.black.withOpacity(0.7),
                      fontWeight: FontWeight.w400),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: onTapSubTitle,
                  child: Text(
                    (subTitle.isEmpty) ? "___" : subTitle,
                    textAlign: TextAlign.end,
                    style: textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: CustomTheme.black.withOpacity(1)),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: bottomPadding.hp,
          ),
          if (hasBottomDivider)
            Container(
              color: CustomTheme.black.withOpacity(0.05),
              height: 0.2,
            ),
        ],
      ),
    );
  }
}
