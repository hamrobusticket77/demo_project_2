import 'package:krishi_hub/feature/notification/model/notification_model.dart';

class AllNotificationRepository {
  final Map<String, NotificationCardModel> _notification = {};
  Map<String, NotificationCardModel> get getNotification => _notification;

  addAll(Map<String, NotificationCardModel> other) {
    _notification.addAll(other);
  }

  updated(String id) {
    NotificationCardModel? value = _notification[id];
    if (value != null) {
      value = value.copyWith(isRead: true);

      _notification[id] = value;
    }
  }
}
