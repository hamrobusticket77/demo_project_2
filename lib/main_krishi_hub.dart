import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:krishi_hub/common/app/app_krishi_hub.dart';
import 'package:krishi_hub/common/app/local_wrapper.dart';
import 'package:krishi_hub/common/constant/custom_locale.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/hive/auth_hive.dart';
import 'package:krishi_hub/common/hive/hive_storage.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/feature/notification/utils/notification_utils.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await FlutterDownloader.initialize(debug: true);

    await EasyLocalization.ensureInitialized();
    WidgetsFlutterBinding.ensureInitialized();

    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: NotificationUtils.notificationChannelKey,
          channelName: 'default_notification_channel',
          channelDescription: 'Default Notification Channel for Krishi Portal.',
          // ledColor: Colors.white,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: true,
        )
      ],
    );

    await AuthHive().init();

    await HiveStorage().init();

    await CustomLocale.getFallBackLocal();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(
        LocalWrapper(
          child: App(env: EnvValue.krishihub),
        ),

        // DevicePreview(
        //     enabled: !kReleaseMode,
        //     tools: const [
        //       ...DevicePreview.defaultTools,
        //     ],
        //     builder: (context) =>
        //         LocalWrapper(child: App(env: EnvValue.staging))),
      );
    });
  }, (e, s) {
    Log.e(e);
    Log.d(s);
  });
}
