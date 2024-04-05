import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/model/media_model.dart';

part 'images_model.g.dart';

@HiveType(typeId: 27)
class ImagesModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  bool status;
  @HiveField(3)
  Album album;
  @HiveField(4)
  MediaModel mediaGroup;

  ImagesModel({
    required this.id,
    required this.title,
    required this.status,
    required this.album,
    required this.mediaGroup,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'status': status,
      'album': album.toMap(),
      'mediaGroup': mediaGroup.toMap(),
    };
  }

  factory ImagesModel.fromMap(Map<String, dynamic> map) {
    return ImagesModel(
      id: map['id'].toString(),
      title: map['title'] ?? "",
      status: map['status'] ?? "",
      album: Album.fromMap(map['album'] as Map<String, dynamic>),
      mediaGroup: MediaModel.fromMap(map['mediaGroup'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory ImagesModel.fromJson(String source) =>
      ImagesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ImagesModel copyWith({
    String? id,
    String? title,
    bool? status,
    DateTime? createdAt,
    Album? album,
    MediaModel? mediaGroup,
  }) {
    return ImagesModel(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      album: album ?? this.album,
      mediaGroup: mediaGroup ?? this.mediaGroup,
    );
  }

  @override
  String toString() {
    return 'ImagesModel(id: $id, title: $title, status: $status, album: $album, mediaGroup: $mediaGroup)';
  }

  @override
  bool operator ==(covariant ImagesModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.status == status &&
        other.album == album &&
        other.mediaGroup == mediaGroup;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        status.hashCode ^
        album.hashCode ^
        mediaGroup.hashCode;
  }
}

@HiveType(typeId: 28)
class Album {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final bool status;

  Album({
    required this.id,
    required this.title,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'status': status,
    };
  }

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      id: map['id'] as int,
      title: map['title'] as String,
      status: map['status'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Album.fromJson(String source) =>
      Album.fromMap(json.decode(source) as Map<String, dynamic>);

  Album copyWith({
    int? id,
    String? title,
    bool? status,
    DateTime? createdAt,
  }) {
    return Album(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'Album(id: $id, title: $title, status: $status, )';
  }

  @override
  bool operator ==(covariant Album other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title && other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ status.hashCode;
  }
}
