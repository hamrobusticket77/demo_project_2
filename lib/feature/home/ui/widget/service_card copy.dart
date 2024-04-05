import 'package:flutter/material.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';

import '../../../../common/app/theme.dart';
import '../../../../common/common_svg_widget.dart';

class ServiceCard extends StatelessWidget {
  final String serviceTitle;
  final String imagePath;
  final double iconHeight;
  final double iconWidth;
  final Function() onPressed;
  const ServiceCard({
    super.key,
    required this.serviceTitle,
    required this.onPressed,
    this.imagePath = "",
    this.iconHeight = 68,
    this.iconWidth = 68,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        borderRadius: BorderRadius.circular(5.hp),
        onTap: onPressed,
        child: Container(
          decoration: const BoxDecoration(color: CustomTheme.white, boxShadow: [
            BoxShadow(
                offset: Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 2,
                color: CustomTheme.lightGray)
          ]),
          padding: EdgeInsets.all(3.wp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonSvgWidget(
                svgName: imagePath,
                height: iconHeight,
                width: iconWidth,
                // color: Theme.of(context).primaryColor,
              ),
              // Icon(
              //   icon,
              //   size: iconsize,
              //   color: Theme.of(context).primaryColor,
              // ),
              SizedBox(height: 5.hp),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      serviceTitle,
                      textAlign: TextAlign.center,
                      maxLines: (serviceTitle.split(" ").length < 2) ? 1 : 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                          // fontSize: 11,
                          overflow: TextOverflow.ellipsis,
                          color: CustomTheme.darkGrey),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
