import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import '../utils/custom_toast.dart';
import '../utils/file_utils.dart';
import '../utils/permission_handler_utils.dart';

class FileDownloadUtils {
  static Future<String?> downloadFile({
    required String downloadLink,
    required String fileName,
    String? additionalPath,
    required BuildContext context,
  }) async {
    final permission = await PermissionHandlerUtils.storagePsermissonHandler();
    if (permission) {
      String? downloadPath;

      if (additionalPath != null) {
        downloadPath = await FileUtils.createCustomDirectory(additionalPath);
      } else {
        downloadPath = await FileUtils.getDownloadPath;
      }
      if (downloadPath != null) {
        debugPrint(downloadLink);

        final String? taskID = await FlutterDownloader.enqueue(
          url: downloadLink,
          savedDir: downloadPath,
          fileName: fileName,
          showNotification: true,
          openFileFromNotification: true,
          saveInPublicStorage: true,
        );
        if (taskID != null) {
          CustomToast.success(message: "downloading");
        }
        return taskID;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
