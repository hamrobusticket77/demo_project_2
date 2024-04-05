import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/common_svg_widget.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';

class CommonWeatherItem extends StatelessWidget {
  final String icon;
  final String title;
  final String subTitle;
  const CommonWeatherItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CommonCardWrapper(
      margin: EdgeInsets.only(bottom: 10.hp),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: CustomTheme.white,
            ),
            child: Center(
                child: CommonSvgWidget(
              svgName: icon,
              width: 18,
              height: 18,
              color: Theme.of(context).colorScheme.tertiary,
            )),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style:
                      const TextStyle(color: CustomTheme.black, fontSize: 18),
                ),
                Text(subTitle,
                    textAlign: TextAlign.end,
                    style: textTheme.titleSmall!
                        .copyWith(fontWeight: FontWeight.w300)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
