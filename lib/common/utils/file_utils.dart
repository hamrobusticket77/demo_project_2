import 'dart:io';

import 'package:krishi_hub/common/utils/log.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<String?> get getDownloadPath async {
    String? externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        final dir = Directory("/storage/emulated/0/Download");
        if (await dir.exists()) {
          externalStorageDirPath = dir.path;
        } else {
          final directory = await getExternalStorageDirectory();
          externalStorageDirPath = directory?.path;
        }
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      try {
        final _path = (await getApplicationDocumentsDirectory()).absolute.path;

        externalStorageDirPath = "$_path/krishi/";
        Log.d(externalStorageDirPath);
      } catch (e) {
        Log.e(e);
      }
      if (externalStorageDirPath != null) {
        final savedDir = Directory(externalStorageDirPath);
        final hasExisted = savedDir.existsSync();
        if (!hasExisted) {
          await savedDir.create(recursive: true);
        }
      }
    }

    return externalStorageDirPath;
  }

  static Future<String> createCustomDirectory(String additionalPath) async {
    String? path = await getDownloadPath;
    if (path != null) {
      Directory newPath = Directory("$path/$additionalPath");
      if (await newPath.exists()) {
        return newPath.path;
      } else {
        final result = await newPath.create(recursive: true);
        if (result.path != null) {
          return newPath.absolute.path;
        } else {
          return "";
        }
      }
    } else {
      return "";
    }
  }
}
