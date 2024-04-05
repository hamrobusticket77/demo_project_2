import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool hasBottomDivider;
  final double bottomPadding;
  const TextWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.hasBottomDivider = true,
    this.bottomPadding = 10,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 17.hp),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$title:",
                style: textTheme.labelLarge!.copyWith(
                    color: CustomTheme.black.withOpacity(0.7),
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                "$subTitle",
                style: textTheme.labelLarge!.copyWith(
                    color: CustomTheme.black.withOpacity(0.7),
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          // if (hasBottomDivider)
          //   Container(
          //     color: CustomTheme.black.withOpacity(0.05),
          //     height: 0.2,
          //   ),
        ],
      ),
    );
  }
}
