import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';

class TextTileListWidget extends StatelessWidget {
  final String title;
  final List<String> subTitle;
  final bool hasBottomDivider;
  final double bottomPadding;
  final Function(int index)? onTapSubTitle;
  const TextTileListWidget({
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(subTitle.length, (index) {
                    return InkWell(
                      onTap: onTapSubTitle == null
                          ? null
                          : () {
                              onTapSubTitle!(index);
                            },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 6.hp, horizontal: 0.wp),
                        child: Text(
                          (subTitle[index].isEmpty) ? "N/A" : subTitle[index],
                          textAlign: TextAlign.end,
                          style: textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: CustomTheme.black.withOpacity(1)),
                        ),
                      ),
                    );
                  }),
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
