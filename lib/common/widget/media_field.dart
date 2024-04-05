import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/model/photos.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/permission_handler_utils.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/button/custom_icon_button.dart';
import 'package:krishi_hub/common/widget/button/custom_rounded_button.dart';
import 'package:krishi_hub/common/widget/file_picker/image_picker_buttom_sheet.dart';
import 'package:krishi_hub/common/widget/file_picker/single_image_picker.dart';

// typedef AddMediaCallBack = Function(File file);

class MultipleMediaFieldWidget extends StatefulWidget {
  final List<ValueNotifier<File>> media;

  // final AddMediaCallBack? addMedia;

  final List<ValueNotifier<Photos>> alreadyUploadedMedia;

  final Function(Photos media) deleteAlreadyUploadMedia;

  const MultipleMediaFieldWidget({
    super.key,
    required this.alreadyUploadedMedia,
    required this.media,
    required this.deleteAlreadyUploadMedia,
  });

  @override
  State<MultipleMediaFieldWidget> createState() =>
      _MultipleMediaFieldWidgetState();
}

class _MultipleMediaFieldWidgetState extends State<MultipleMediaFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomRoundedButton(
              title: LocaleKeys.addImage.tr(),
              borderRadius: 5,
              icon: Icons.image_outlined,
              iconColor: Theme.of(context).primaryColor,
              outlineColor: Theme.of(context).primaryColor,
              color: CustomTheme.white,
              verticalPadding: 8,
              textColor: CustomTheme.black,
              elevation: 0,
              onPressed: () async {
                FocusScope.of(context).unfocus();
                await Future.delayed(const Duration(milliseconds: 100));
                showImagePickerBottomSheet(onGalleryPressed: () async {
                  final res = await ImagePickerUtils.getGallery();
                  NavigationService.pop();
                  if (res != null) {
                    widget.media.add(ValueNotifier(res));
                    setState(() {});
                  }
                }, onCameraPressed: () async {
                  await PermissionHandlerUtils.cameraPermission();
                  final res = await ImagePickerUtils.getCamera();
                  if (res != null) {
                    widget.media.add(ValueNotifier(res));
                    setState(() {});
                  }
                  NavigationService.pop();
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 10.hp,
        ),
        Wrap(
            runSpacing: 10.hp,
            spacing: 10.wp,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ...List.generate(
                widget.alreadyUploadedMedia.length,
                (index) {
                  final data = widget.alreadyUploadedMedia[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Stack(
                      children: [
                        Container(
                          color: CustomTheme.lightGray,
                          child: ValueListenableBuilder<Photos>(
                              valueListenable: data,
                              builder: ((context, value, child) {
                                return Container(
                                  width: 90,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black12,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          value.path,
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                );
                              })),
                        ),
                        Positioned(
                          top: 3,
                          right: 3,
                          child: CustomIconButton(
                            backgroundColor: CustomTheme.lighterGrey,
                            icon: Icons.cancel,
                            verticalPadding: 5,
                            horizontalPadding: 5,
                            iconSize: 12,
                            iconColor: CustomTheme.red,
                            onPressed: () async {
                              widget.deleteAlreadyUploadMedia(
                                  widget.alreadyUploadedMedia[index].value);
                              widget.alreadyUploadedMedia.removeAt(index);
                              setState(() {});
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              ...List.generate(
                widget.media.length,
                (index) {
                  final data = widget.media[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Stack(
                      children: [
                        Container(
                          color: CustomTheme.lightGray,
                          child: ValueListenableBuilder<File?>(
                              valueListenable: data,
                              builder: ((context, value, child) {
                                return Container(
                                  width: 90,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black12,
                                    image: value == null
                                        ? null
                                        : DecorationImage(
                                            image: FileImage(
                                              value,
                                            ),
                                            fit: BoxFit.cover),
                                  ),
                                );
                              })),
                        ),
                        Positioned(
                            top: 3,
                            right: 3,
                            child: CustomIconButton(
                              backgroundColor: CustomTheme.lighterGrey,
                              icon: Icons.cancel,
                              verticalPadding: 5,
                              horizontalPadding: 5,
                              iconSize: 12,
                              iconColor: CustomTheme.red,
                              onPressed: () async {
                                widget.media.removeAt(index);
                                setState(() {});
                              },
                            ))
                      ],
                    ),
                  );
                },
              ),
            ]),
      ],
    );
  }
}
