import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/route/route.dart';
import 'package:krishi_hub/feature/notification/resource/notification_repository.dart';
import 'package:krishi_hub/feature/notification/utils/notification_utils.dart';

class NotificationWrapper extends StatefulWidget {
  final Widget child;

  const NotificationWrapper({super.key, required this.child});

  @override
  State<NotificationWrapper> createState() => _NotificationWrapperState();
}

class _NotificationWrapperState extends State<NotificationWrapper> {
  Future<void> firebaseInitiliz() async {
    await Firebase.initializeApp();
  }

  @pragma("vm:entry-point")
  Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("notification created");

    await NotificationUtils.incrementNotficationCount();
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
    // notificationCount.value = notificationCount.value + 1;
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
    await NotificationUtils.decrementNotificationCount();
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    await NotificationUtils.decrementNotificationCount();

    if (receivedAction.actionLifeCycle == NotificationLifeCycle.Terminated) {
      Future.sync(() async {
        await RepositoryProvider.of<NotificationRepository>(
                NavigationService.context)
            .setAppOpenNotification(true);
      });
    } else {
      Future.sync(() {
        NavigationService.pushNamedAndRemoveUntil(
            routeName: Routes.dashboardPage, args: true);
        NavigationService.pushNamed(routeName: Routes.notificationPage);
      }).whenComplete(() {
        NotificationUtils.clearNotificationCount();
      });
    }
  }

  void notificaitonMessage() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  void initState() {
    notificaitonMessage();
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
    initializeRemoteNotifications(debug: false);
    // getFirebaseMessagingToken();
    NotificationUtils.initNotficationCount();

    // AwesomeNotifications().
    super.initState();
  }

  Future<String> getFirebaseMessagingToken() async {
    String firebaseAppToken = '';
    if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
      try {
        firebaseAppToken =
            await AwesomeNotificationsFcm().requestFirebaseAppToken();
        debugPrint(firebaseAppToken);
      } catch (exception) {
        debugPrint('$exception');
      }
    } else {
      debugPrint('Firebase is not available on this project');
    }
    return firebaseAppToken;
  }

  Future<void> initializeRemoteNotifications({required bool debug}) async {
    await firebaseInitiliz();
    await AwesomeNotificationsFcm().initialize(
      onFcmSilentDataHandle: mySilentDataHandle,
      onFcmTokenHandle: myFcmTokenHandle,
      onNativeTokenHandle: myNativeTokenHandle,
      debug: debug,
    );

    await getFirebaseMessagingToken();
  }

  //  *********************************************
  ///     REMOTE NOTIFICATION EVENTS
  ///  *********************************************

  /// Use this method to execute on background when a silent data arrives
  /// (even while terminated)
  @pragma("vm:entry-point")
  static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
    print('"SilentData": ${silentData.toString()}');

    final data = silentData.data;

    if (data != null) {
      await NotificationUtils.createLocalNotification(
        title: data['title'],
        body: data['body'],
      );
      // notificationCount.value = notificationCount.value++;
    }

    if (silentData.createdLifeCycle != NotificationLifeCycle.Foreground) {
      print("bg");
    } else if (silentData.createdLifeCycle !=
        NotificationLifeCycle.Terminated) {
    } else {
      print("FOREGROUND");
    }

    print("long task done");
  }

  /// Use this method to detect when a new fcm token is received
  @pragma("vm:entry-point")
  static Future<void> myFcmTokenHandle(String token) async {
    debugPrint('FCM Token:"$token"');
  }

  /// Use this method to detect when a new native token is received
  @pragma("vm:entry-point")
  static Future<void> myNativeTokenHandle(String token) async {
    debugPrint('Native Token:"$token"');
    debugPrint("here");
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
