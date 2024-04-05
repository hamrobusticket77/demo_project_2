import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/constant_assets.dart';
import 'package:krishi_hub/common/image/custom_cache_network_image.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';

viewImageDialog(context, image) {
  return showDialog(
    context: context,
    builder: ((context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(5.0), // Set your desired radius here
          ),
          insetPadding: EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding.wp, vertical: 20.hp),
          child: InteractiveViewer(
            panEnabled: true, // Set it to false
            boundaryMargin: const EdgeInsets.all(0),
            minScale: 1,
            maxScale: 3,
            child: CustomCachedNetworkImage(
              placeholder: Assets.placeholder,
              url: image ?? "",
              fit: BoxFit.contain,
            ),
          ),
        )),
  );
}
