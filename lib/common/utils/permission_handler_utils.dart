import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/device_info_utils.dart';
import 'package:krishi_hub/common/widget/permission_alert_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerUtils {
  static Future<bool> locationPermissionHandler() async {
    if (await Permission.location.isGranted) {
      return true;
    } else {
      await Permission.location.request();

      if (await Permission.location.isDenied) {
        permissionAlertDialog(
            subtitle: 'Location permission required',
            title: 'The app needs location permission to function properly');
        return false;
      } else if (await Permission.location.isPermanentlyDenied) {
        permissionAlertDialog(
            subtitle: 'Location permission required',
            title: 'The app needs location permission to function properly');
        return false;
      } else {
        return false;
      }
    }
  }

  static Future<bool> storagePsermissonHandler() async {
    final value = await Permission.accessMediaLocation.request();

    if (Platform.isAndroid) {
      final sdk = await DeviceInfoUtils.getSdkVersion();

      if (sdk != null && sdk > 32) {
        if (await Permission.mediaLibrary.isGranted) {
          return true;
        } else {
          await Permission.mediaLibrary.request();
          if (await Permission.mediaLibrary.isDenied) {
            permissionAlertDialog(
                subtitle: 'Storage permission required',
                title: 'The app needs storage permission to function properly');
            return false;
          } else if (await Permission.storage.isPermanentlyDenied) {
            permissionAlertDialog(
                subtitle: 'Storage permission required',
                title: 'The app needs storage permission to function properly');
            return false;
          } else {
            return false;
          }
        }
      } else if (await Permission.storage.isGranted) {
        return true;
      } else {
        await Permission.storage.request();

        if (await Permission.storage.isDenied) {
          permissionAlertDialog(
              subtitle: 'Storage permission required',
              title: 'The app needs storage permission to function properly');
          return false;
        } else if (await Permission.storage.isPermanentlyDenied) {
          permissionAlertDialog(
              subtitle: 'Storage permission required',
              title: 'The app needs storage permission to function properly');
          return false;
        } else {
          return false;
        }
      }
    } else if (Platform.isIOS) {
      if (await Permission.storage.isGranted) {
        return true;
      } else {
        await Permission.storage.request();

        if (await Permission.storage.isDenied) {
          permissionAlertDialog(
              subtitle: 'Storage permission required',
              title: 'The app needs storage permission to function properly');
          return false;
        } else if (await Permission.storage.isPermanentlyDenied) {
          permissionAlertDialog(
              subtitle: 'Storage permission required',
              title: 'The app needs storage permission to function properly');
          return false;
        } else {
          return false;
        }
      }
    } else {
      return false;
    }
  }

  static Future<bool> photoPermission() async {
    if (await Permission.photos.isGranted &&
        await Permission.videos.isGranted &&
        await Permission.audio.isGranted) {
      return true;
    } else {
      await Permission.photos.request();
      await Permission.videos.request();
      await Permission.audio.request();

      if (await Permission.photos.isDenied) {
        permissionAlertDialog(
            subtitle: 'Storage permission required',
            title: 'The app needs storage permission to function properly');
        return false;
      } else if (await Permission.photos.isPermanentlyDenied) {
        permissionAlertDialog(
            subtitle: 'Storage permission required',
            title: 'The app needs storage permission to function properly');
        return false;
      } else {
        return false;
      }
    }
  }

  // static Future<bool> documentPermission() async {
  //   await Permission.photosAddOnly.request();
  //   return true;
  //   // if (await Permission.mediaLibrary.isGranted) {
  //   //   return true;
  //   // } else {
  //   //   await Permission.photos.request();

  //   //   if (await Permission.photos.isDenied) {
  //   //     permissionAlertDialog(
  //   //         subtitle: 'Storage permission required',
  //   //         title: 'The app needs storage permission to function properly');
  //   //     return false;
  //   //   } else if (await Permission.photos.isPermanentlyDenied) {
  //   //     permissionAlertDialog(
  //   //         subtitle: 'Storage permission required',
  //   //         title: 'The app needs storage permission to function properly');
  //   //     return false;
  //   //   } else {
  //   //     return false;
  //   //   }
  //   // }
  // }

  // static Future<void> externalStoragePermission() async {
  //   final status = await Permission.storage.status;
  //   await Permission.manageExternalStorage.request();
  //   if (status != PermissionStatus.granted) {
  //     await Permission.storage.request();
  //   }
  //   if (await Permission.manageExternalStorage.isDenied) {
  //     await Permission.manageExternalStorage.request();
  //   }
  // }

  static Future<bool> cameraPermission() async {
    if (await Permission.camera.isGranted) {
      return true;
    } else {
      await Permission.camera.request();
      if (await Permission.camera.isDenied) {
        permissionAlertDialog(
            subtitle: 'Camera permission required',
            title: 'The app needs camera permission to function properly');
        return false;
      } else if (await Permission.camera.isPermanentlyDenied) {
        permissionAlertDialog(
            subtitle: 'Camera permission required',
            title: 'The app needs camera permission to function properly');
        return false;
      } else {
        return false;
      }
    }
  }

  static notificationPermission() async {
    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: NavigationService.context,
            builder: (context) => AlertDialog(
              title: const Text('Allow Notifications'),
              content:
                  const Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: Text(
                    'Allow',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
