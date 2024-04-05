// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:krishi_hub/common/utils/permission_handler_utils.dart';
// import 'package:krishi_hub/common/utils/custom_toast.dart';
// import 'package:krishi_hub/common/utils/file_utils.dart';

// class FileDownloadUtils {
//   static Future<String?> downloadFile({
//     required String downloadLink,
//     required String fileName,
//     String? additionalPath,
//     required BuildContext context,
//   }) async {
//     final permission = await PermissionHandlerUtils.storagePsermissonHandler();
//     if (permission) {
//       String? downloadPath;

//       if (additionalPath != null) {
//         downloadPath = await FileUtils.createCustomDirectory(additionalPath);
//       } else {
//         downloadPath = await FileUtils.getDownloadPath;
//       }
//       if (downloadPath != null) {
//         debugPrint(downloadLink);

//         final String? taskID = await FlutterDownloader.enqueue(
//             url: downloadLink,
//             savedDir: downloadPath,
//             fileName: "nirmal",
//             showNotification: true,
//             openFileFromNotification: true,
//             saveInPublicStorage: true);
//         if (taskID != null) {
//           CustomToast.success(message: "downloading");
//         }
//         return taskID;
//       } else {
//         return null;
//       }
//     } else {
//       return null;
//     }
//   }

//   // static Future<File> downloadFileFromBufferCode({
//   //   required String bufferCode,
//   //   required String fileName,
//   //   required BuildContext context,
//   // }) async {
//   //   try {
//   //     await PermissionHandlerUtils.externalStoragePermission();
//   //     final String? downloadPath = await FileUtils.getDownloadPath;
//   //     final file = File("$downloadPath/$fileName");
//   //     if (!file.existsSync()) {
//   //       await File("$downloadPath/$fileName").create(recursive: true);
//   //     }

//   //     final byteData = base64.decode(bufferCode);

//   //     final value = await file.writeAsBytes(byteData, mode: FileMode.write);
//   //     // String decodedpath = value.path;
//   //     // debugPrint(decodedpath);
//   //     return value;
//   //   } catch (e) {
//   //     debugPrint(e.toString());
//   //     CustomToast.error(message: "file download failed");
//   //     rethrow;
//   //   }
//   // }
// }
