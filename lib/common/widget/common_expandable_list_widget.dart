import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/common/widget/common_expandable_widget.dart';

class CommonExpandableListWidget extends StatelessWidget {
  final String title;
  final Widget body;
  final bool hasShadow;
  final int index;
  final double bodyPadding;
  final Color? bgColor;

  final EdgeInsetsGeometry? margin;

  const CommonExpandableListWidget({
    super.key,
    required this.title,
    required this.index,
    required this.body,
    this.bodyPadding = 34,
    this.bgColor,
    this.hasShadow = true,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCardWrapper(
      margin: margin,
      hasShadow: hasShadow,
      backgroundColor: bgColor ?? CustomTheme.white,
      child: CommonExpandableWidget(
        // bgColor: Colors.white,
        header: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    decoration: const BoxDecoration(
                        color: CustomTheme.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 2,
                              spreadRadius: 2,
                              color: CustomTheme.lightGray)
                        ]),
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      "${"${index + 1}".toNepali()}.",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                SizedBox(
                  width: 10.wp,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.hp,
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: bodyPadding.wp,
                ),
                Expanded(
                  child: body,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
