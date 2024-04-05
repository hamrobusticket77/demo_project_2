import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:krishi_hub/common/utils/custom_toast.dart';

class UpdateWrapper extends StatefulWidget {
  final Widget child;

  const UpdateWrapper({
    super.key,
    required this.child,
  });

  @override
  State<UpdateWrapper> createState() => _UpdateWrapperState();
}

class _UpdateWrapperState extends State<UpdateWrapper> {
  Future<void> _checkInApp(BuildContext context) async {
    InAppUpdate.checkForUpdate().then((value) async {
      if (value.immediateUpdateAllowed) {
        final AppUpdateResult result =
            await InAppUpdate.performImmediateUpdate();
        if (context.mounted) {
          if (result == AppUpdateResult.inAppUpdateFailed) {
            CustomToast.error(message: "update failed");
          } else if (result == AppUpdateResult.success) {
            CustomToast.error(message: "Update Success");
          }
        }
      }
    });
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500)).whenComplete(() {
      _checkInApp(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
