import 'package:flutter/material.dart';
import 'package:krishi_hub/common/constant/constant_assets.dart';
import 'package:krishi_hub/common/image/custom_cache_network_image.dart';

class CustomRoundedImage extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final Widget? customPlaceHolder;
  final String fallBackImage;
  const CustomRoundedImage({
    Key? key,
    required this.height,
    required this.image,
    required this.width,
    this.customPlaceHolder,
    this.fallBackImage = Assets.userPlaceHolder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height > width ? height : width),
      child: CustomCachedNetworkImage(
        url: image,
        height: height,
        width: width,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        // customPlaceHolder: customPlaceHolder,
        // placeholder: fallBackImage,
      ),
    );
  }
}
