import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/widget/button/custom_icon_button.dart';

import '../../navigation/navigation_service.dart';

showImagePickerBottomSheet({
  required Function? onGalleryPressed,
  required Function? onCameraPressed,
  bool showCameraOption = true,
  bool showGalleryOption = true,
  String description = '',
}) {
  return showModalBottomSheet(
    context: NavigationService.context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(36),
        topRight: Radius.circular(36),
      ),
    ),
    builder: (context) {
      return ImagePickerBottomSheet(
        onGalleryPressed: onGalleryPressed,
        onCameraPressed: onCameraPressed,
        showCameraOption: showCameraOption,
        showGalleryOption: showGalleryOption,
        description: description,
      );
    },
  );
}

class ImagePickerBottomSheet extends StatefulWidget {
  final Function? onGalleryPressed;
  final Function? onCameraPressed;
  final bool showCameraOption;
  final bool showGalleryOption;
  final String description;
  const ImagePickerBottomSheet(
      {Key? key,
      this.onGalleryPressed,
      this.onCameraPressed,
      this.showCameraOption = true,
      this.showGalleryOption = true,
      required this.description})
      : super(key: key);

  @override
  State<ImagePickerBottomSheet> createState() => _ImagePickerBottomSheetState();
}

class _ImagePickerBottomSheetState extends State<ImagePickerBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 24, bottom: 24),
            height: 4,
            width: 55,
            decoration: BoxDecoration(
              color: CustomTheme.lightGray.withOpacity(0.4),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Text(
            "Image upload",
            style: textTheme.displaySmall,
          ),
          const SizedBox(height: 43),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.showGalleryOption)
                  CustomIconButton(
                    icon: Icons.photo_library_sharp,
                    borderRadius: 10,
                    iconSize: 26,
                    iconColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (widget.onGalleryPressed != null) {
                        widget.onGalleryPressed!();
                      }
                    },
                  ),
                if (widget.showCameraOption && widget.showGalleryOption)
                  const SizedBox(width: 34),
                if (widget.showCameraOption)
                  CustomIconButton(
                    icon: Icons.camera,
                    borderRadius: 10,
                    iconSize: 26,
                    iconColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (widget.onCameraPressed != null) {
                        widget.onCameraPressed!();
                      }
                    },
                  )
              ],
            ),
          ),
          if (widget.description.isNotEmpty) const SizedBox(height: 30),
          if (widget.description.isNotEmpty)
            Text(
              widget.description,
              style: textTheme.bodyLarge!.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: CustomTheme.lightGray,
              ),
            ),
          SizedBox(height: widget.description.isNotEmpty ? 30 : 60),
        ],
      ),
    );
  }
}
