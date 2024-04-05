//DownloadsModel

import 'package:easy_localization/easy_localization.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../common/model/photos.dart';

part 'downloads_model.g.dart';

@HiveType(typeId: 45)
class DownloadsModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final List<Photos> media;

  @HiveField(4)
  final String createdAt;
  @HiveField(5)
  final String updatedAt;
  @HiveField(6)
  final String date;
  DownloadsModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.createdAt,
      required this.updatedAt,
      required this.date,
      required this.media});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      "media": media.map((e) => e.toMap()).toList(),
      'date': date,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }

  factory DownloadsModel.fromJson(Map<String, dynamic> json) {
    return DownloadsModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      media: List.from(json['media']).map((e) => Photos.fromMap(e)).toList(),
      createdAt: json['createdAt'] ?? '',
      date: json['date'] ?? "",
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  String get getCreatedDate {
    final DateFormat formatter = DateFormat('MMMM d, y');

    final temp = DateTime.tryParse(createdAt);
    if (temp != null) {
      return formatter.format(temp);
    }
    return "";
  }
}
