import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'constant/constant_assets.dart';

class CommonErrorWidget extends StatelessWidget {
  final String message;
  final String svgUrl;
  final double height;
  final double width;
  final bool hideImage;
  const CommonErrorWidget({
    super.key,
    required this.message,
    this.svgUrl = Assets.error,
    this.height = 100,
    this.width = 100,
    this.hideImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!hideImage)
            AspectRatio(
              aspectRatio: 1.5,
              child: SvgPicture.asset(
                svgUrl, height: 10, width: 10,
                // height: height,
                // width: width,
              ),
            ),
          SizedBox(
            height: 30.hp,
          ),
          Text(message),
        ],
      ),
    );
  }
}
