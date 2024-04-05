import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/model/media_model.dart';
import 'package:nepali_utils/nepali_utils.dart';

part 'news_model.g.dart';

@HiveType(typeId: 2)
class NewsModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String createdAt;
  @HiveField(4)
  final MediaModel media;
  @HiveField(5)
  final String updatedAt;
  @HiveField(6)
  final String date;
  @HiveField(7)
  final bool isScrolling;
  NewsModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.updatedAt,
      required this.date,
      required this.isScrolling,
      required this.media});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      "isScrolling": isScrolling,
      "media": media.toMap()
    };
  }

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['createdAt'] ?? '',
      date: json['date'] ?? "",
      updatedAt: json['updatedAt'] ?? '',
      isScrolling: json['isScrolling'] ?? '',
      media: MediaModel.fromMap(json['media'] ?? {}),
    );
  }

  String get getCreatedDate {
    final NepaliDateFormat formatter = NepaliDateFormat('MMMM d, y');

    final temp = DateTime.tryParse(createdAt);
    if (temp != null) {
      return formatter.format(temp.toNepaliDateTime());
    }
    return "";
  }
}
