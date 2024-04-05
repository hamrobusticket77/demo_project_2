import 'package:flutter/material.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:permission_handler/permission_handler.dart';

permissionAlertDialog({required String title, required String subtitle}) {
  showDialog(
    context: NavigationService.context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: [
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.pop(context);
            },
            child: const Text('Open app settings'),
          ),
        ],
      );
    },
  );
}
