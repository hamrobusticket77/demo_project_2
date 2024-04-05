import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'image_album_model.g.dart';

@HiveType(typeId: 49)
class ImageAlbumModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final bool status;

  @HiveField(3)
  final String createAt;
  ImageAlbumModel({
    required this.id,
    required this.title,
    required this.status,
    required this.createAt,
  });

  ImageAlbumModel copyWith({
    int? id,
    String? title,
    bool? status,
    String? createAt,
  }) {
    return ImageAlbumModel(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      createAt: createAt ?? this.createAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'status': status,
      'createAt': createAt,
    };
  }

  factory ImageAlbumModel.fromMap(Map<String, dynamic> map) {
    return ImageAlbumModel(
      id: map['id'] ?? -1,
      title: map['title'] ?? "",
      status: map['status'] ?? false,
      createAt: map['createAt'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageAlbumModel.fromJson(String source) =>
      ImageAlbumModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ImageAlbumModel(id: $id, title: $title, status: $status, createAt: $createAt)';
  }

  @override
  bool operator ==(covariant ImageAlbumModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.status == status &&
        other.createAt == createAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ status.hashCode ^ createAt.hashCode;
  }
}
