import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/constant/constant_assets.dart';
import 'package:krishi_hub/common/image/custom_network_image.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/pdf_viewer_widget.dart';
import 'package:krishi_hub/common/widget/view_image_dialog.dart';
import 'package:krishi_hub/feature/downloads/models/downloads_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewDownloadDataWidget extends StatelessWidget {
  final DownloadsModel model;

  const ViewDownloadDataWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(CustomTheme.symmetricHozPadding),
        child: Column(
          children: List.generate(model.media.length, (index) {
            final data = model.media[index];

            if (data.isPdf) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            NavigationService.push(
                                target: PdfViewerWidget(pdfPath: data.path));
                          },
                          child: Text("view pdf in fullpage"))
                    ],
                  ),
                  SizedBox(
                    height: 500.hp,
                    child: CommonCardWrapper(
                        margin: const EdgeInsets.all(0),
                        child: SfPdfViewer.network(
                          data.path,
                        )),
                  ),
                  Divider()
                ],
              );
            } else if (data.isImage) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      viewImageDialog(context, data.path);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: CustomTheme.grey,
                        border: Border.all(
                          // width: 1,
                          color: CustomTheme.lightGray,
                        ),
                      ),
                      child: CustomNetWorkImage(
                        imageUrl: data.path,
                        // height: 100,
                        boxFit: BoxFit.contain,
                        placeHolder: Assets.placeholder,
                      ),
                    ),
                  ),
                  const Divider()
                ],
              );
            } else {
              return const SizedBox();
            }
          }),
        ),
      )),
    );
  }
}
