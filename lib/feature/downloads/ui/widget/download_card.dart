import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/custom_toast.dart';

import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/date_formater_utils.dart';
import 'package:krishi_hub/common/widget/button/custom_icon_button.dart';
import 'package:krishi_hub/common/widget/downloads.dart';
import 'package:krishi_hub/feature/downloads/models/downloads_model.dart';
import 'package:krishi_hub/feature/downloads/ui/pages/view_download_data_page.dart';

class DownloadCard extends StatefulWidget {
  final Function()? onPressed;
  final EdgeInsetsGeometry? margin;
  final DownloadsModel downloadsModel;

  const DownloadCard({
    super.key,
    required this.downloadsModel,
    required this.onPressed,
    this.margin,
  });

  @override
  State<DownloadCard> createState() => _DownloadCardState();
}

class _DownloadCardState extends State<DownloadCard> {
  void _mediaChecker(void Function() function) {
    if (widget.downloadsModel.media.isNotEmpty) {
      function();
    } else {
      CustomToast.error(message: "Media not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CommonCardWrapper(
      margin: widget.margin ??
          EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding.wp, vertical: 10.hp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  widget.downloadsModel.name,
                  style: textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: CustomTheme.black,
                  ),
                  // overflow: TextOverflow.ellipsis,
                  // maxLines: 3,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          // Text(
          //   DateFormatterUtils.convertAdIntoBs(widget.downloadsModel.createdAt),
          //   style: textTheme.titleSmall!.copyWith(
          //     color: CustomTheme.black,
          //   ),
          // ),

          Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                size: 15,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                DateFormatterUtils.convertAdIntoBsString(
                    widget.downloadsModel.createdAt),
                style: textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: CustomTheme.grey,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomIconButton(
                icon: Icons.download,
                onPressed: () {
                  _mediaChecker(() async {
                    // await FileDownloadUtils.downloadFile(
                    //     downloadLink: widget.downloadsModel.media.first.path,
                    //     fileName: widget.downloadsModel.name,
                    //     context: context);

                    for (var value in widget.downloadsModel.media) {
                      await FileDownloadUtils.downloadFile(
                          downloadLink: value.path,
                          fileName: value.fileName,
                          context: context);
                    }
                  });
                },
                borderRadius: 5,
                verticalPadding: 10,
                horizontalPadding: 10,
                hasBorderOutline: true,
                outlineBorderWidth: 1,
                iconColor: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 5),
              CustomIconButton(
                icon: Icons.visibility,
                onPressed: () {
                  NavigationService.push(
                      target:
                          ViewDownloadDataPage(model: widget.downloadsModel));
                },
                borderRadius: 5,
                verticalPadding: 10,
                horizontalPadding: 10,
                hasBorderOutline: true,
                outlineBorderWidth: 1,
                iconColor: Theme.of(context).primaryColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
