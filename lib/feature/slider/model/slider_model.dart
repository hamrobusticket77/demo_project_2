import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/model/media_model.dart';

part 'slider_model.g.dart';

@HiveType(typeId: 5)
class SliderModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  MediaModel media;
  SliderModel({
    required this.id,
    required this.title,
    required this.media,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'media': media.toMap(),
    };
  }

  factory SliderModel.fromMap(Map<String, dynamic> map) {
    return SliderModel(
      id: (map['id'] != null) ? map['id'].toString() : "-1",
      title: map['title'] ?? "",
      media: MediaModel.fromMap(map['media'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory SliderModel.fromJson(String source) =>
      SliderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  SliderModel copyWith({
    String? id,
    String? title,
    MediaModel? media,
  }) {
    return SliderModel(
      id: id ?? this.id,
      title: title ?? this.title,
      media: media ?? this.media,
    );
  }

  @override
  String toString() => 'SliderModel(id: $id, title: $title, media: $media)';

  @override
  bool operator ==(covariant SliderModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title && other.media == media;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ media.hashCode;
}

bool isImage(name) {
  String extension = name.split(".").last;

  if (extension == "jpg" || extension == "png" || extension == "jpeg") {
    return true;
  }
  return false;
}
