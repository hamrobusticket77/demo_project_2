import 'package:flutter/material.dart';
import 'package:krishi_hub/feature/downloads/models/downloads_model.dart';
import 'package:krishi_hub/feature/downloads/ui/widget/view_download_data_widget.dart';

class ViewDownloadDataPage extends StatelessWidget {
  final DownloadsModel model;

  const ViewDownloadDataPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return ViewDownloadDataWidget(
      model: model,
    );
  }
}
