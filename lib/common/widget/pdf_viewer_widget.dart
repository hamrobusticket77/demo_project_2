import 'package:flutter/material.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerWidget extends StatelessWidget {
  final String pdfPath;

  const PdfViewerWidget({
    super.key,
    required this.pdfPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Pdf",
      ),
      body: SfPdfViewer.network(
        pdfPath,
      ),
    );
  }
}
