import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';

class NotificationUtils {
  static ValueNotifier<int> notificationCount = ValueNotifier(0);

  static const String notificationChannelKey =
      "notification_notification_channel";

  static const String notificationChannelKeyBenighat =
      "notification_notification_channel_benighat";
  // static const String alert = "alert";

  // static LocalPushNotification convertToLocalPushNofication(
  //     Map<String, dynamic> json) {
  //   return LocalPushNotification(
  //     id: json["id"] ?? "",
  //     type: json["model"] ?? "",
  //     deeplink: json["deeplink"],
  //   );
  // }

  static Future createLocalNotification(
      {String? title, String? body, int? id}) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: id ?? DateTime.now().millisecondsSinceEpoch.remainder(100000),
      channelKey: notificationChannelKey,
      title: title ?? "",
      body: body ?? "",
      actionType: ActionType.Default,
      displayOnBackground: true,
      displayOnForeground: true,
      // backgroundColor: Theme.of(NavigationService.context).primaryColor,
      largeIcon: "asset://assets/images/app_icon.png",
      notificationLayout: NotificationLayout.Default,
    ));
  }

  static Future initNotficationCount() async {
    notificationCount.value =
        await AwesomeNotifications().getGlobalBadgeCounter();
  }

  static Future incrementNotficationCount() async {
    await AwesomeNotifications().incrementGlobalBadgeCounter();
    notificationCount.value = notificationCount.value + 1;
  }

  static Future decrementNotificationCount() async {
    final count = await AwesomeNotifications().getGlobalBadgeCounter();

    if (count > 0) {
      await AwesomeNotifications().decrementGlobalBadgeCounter();
      notificationCount.value = notificationCount.value - 1;
    }
  }

  static Future clearNotificationCount() async {
    await AwesomeNotifications().resetGlobalBadge();
    notificationCount.value = 0;
    // notificationCount.notifyListeners();
  }
}
