import 'package:krishi_hub/feature/demand/model/demand_model.dart';
import 'package:krishi_hub/feature/traning/model/training_model.dart';

class NotificationCardModel {
  String id;
  String createdAt;
  String? deletedAt;
  String serviceName;
  String title;
  String body;
  String viewType;
  bool isRead;
  String publishedDate;
  TrainingModel? training;
  DemandModel? demand;
  NotificationCardModel({
    required this.id,
    required this.createdAt,
    this.deletedAt,
    required this.serviceName,
    required this.title,
    required this.body,
    required this.viewType,
    required this.isRead,
    required this.publishedDate,
    this.training,
    this.demand,
  });

  NotificationCardModel copyWith({
    String? id,
    String? createdAt,
    String? deletedAt,
    String? serviceName,
    String? title,
    String? body,
    String? viewType,
    bool? isRead,
    String? publishedDate,
    TrainingModel? training,
    DemandModel? demand,
  }) {
    return NotificationCardModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serviceName: serviceName ?? this.serviceName,
      title: title ?? this.title,
      body: body ?? this.body,
      viewType: viewType ?? this.viewType,
      isRead: isRead ?? this.isRead,
      publishedDate: publishedDate ?? this.publishedDate,
      training: training ?? this.training,
      demand: demand ?? this.demand,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'deletedAt': deletedAt,
      'serviceName': serviceName,
      'title': title,
      'body': body,
      'viewType': viewType,
      'isRead': isRead,
      'publishedDate': publishedDate,
      'training': training?.toMap(),
      'demand': demand?.toMap(),
    };
  }

  factory NotificationCardModel.fromMap(Map<String, dynamic> map) {
    return NotificationCardModel(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      deletedAt: map['deletedAt'] != null ? map['deletedAt'] ?? "" : null,
      serviceName: map['serviceName'] ?? "",
      title: map['title'] ?? "",
      body: map['body'] ?? "",
      viewType: map['viewType'] ?? "",
      isRead: map['isRead'] ?? false,
      publishedDate: map['publishedDate'] ?? "",
      training: map['training'] != null
          ? TrainingModel.fromMap(map['training'] ?? {})
          : null,
      demand: map['demand'] != null
          ? DemandModel.fromMap(map['demand'] ?? {})
          : null,
    );
  }

  @override
  bool operator ==(covariant NotificationCardModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.deletedAt == deletedAt &&
        other.serviceName == serviceName &&
        other.title == title &&
        other.body == body &&
        other.viewType == viewType &&
        other.isRead == isRead &&
        other.publishedDate == publishedDate &&
        other.training == training &&
        other.demand == demand;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        deletedAt.hashCode ^
        serviceName.hashCode ^
        title.hashCode ^
        body.hashCode ^
        viewType.hashCode ^
        isRead.hashCode ^
        publishedDate.hashCode ^
        training.hashCode ^
        demand.hashCode;
  }
}
