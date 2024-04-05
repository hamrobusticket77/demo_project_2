import 'package:krishi_hub/feature/downloads/models/downloads_model.dart';

class AllDownloadRepository {
  final Map<String, DownloadsModel> _getdownloadpdf = {};
  Map<String, DownloadsModel> get getdwonloadpdflist => _getdownloadpdf;

  addAll(Map<String, DownloadsModel> other) {
    _getdownloadpdf.addAll(other);
  }

  removeAll() {
    _getdownloadpdf.clear();
  }
}
