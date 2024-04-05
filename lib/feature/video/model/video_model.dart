import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:nepali_utils/nepali_utils.dart';

part 'video_model.g.dart';

@HiveType(typeId: 15)
class VideoModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  String videoUrl;
  @HiveField(4)
  bool status;
  @HiveField(5)
  String createdAt;
  @HiveField(6)
  Playlist playlist;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.status,
    required this.createdAt,
    required this.playlist,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'status': status,
      'createdAt': createdAt,
      'playlist': playlist.toMap(),
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'].toString(),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      status: map['status'] as bool,
      createdAt: map['createdAt'] ?? '',
      playlist: Playlist.fromMap(map['playlist'] ?? {}),
    );
  }

  VideoModel copyWith({
    String? id,
    String? title,
    String? description,
    String? videoUrl,
    bool? status,
    String? createdAt,
    Playlist? playlist,
  }) {
    return VideoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      playlist: playlist ?? this.playlist,
    );
  }

  @override
  String toString() {
    return 'VideoModel(id: $id, title: $title, description: $description, videoUrl: $videoUrl, status: $status, createdAt: $createdAt, playlist: $playlist)';
  }

  @override
  bool operator ==(covariant VideoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.videoUrl == videoUrl &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.playlist == playlist;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        videoUrl.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        playlist.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String get getCreatedDate {
    final NepaliDateFormat formatter = NepaliDateFormat('MMMM d, y');

    final temp = DateTime.tryParse(createdAt);
    if (temp != null) {
      return formatter.format(temp.toNepaliDateTime());
    }
    return "";
  }
}

@HiveType(typeId: 16)
class Playlist {
  @HiveField(0)
  int id;
  @HiveField(1)
  bool status;
  Playlist({
    required this.id,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
    };
  }

  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      id: map['id'] as int,
      status: map['status'] as bool,
    );
  }

  Playlist copyWith({
    int? id,
    bool? status,
    DateTime? createdAt,
  }) {
    return Playlist(
      id: id ?? this.id,
      status: status ?? this.status,
    );
  }

  @override
  String toString() => 'Playlist(id: $id, status: $status, )';

  @override
  bool operator ==(covariant Playlist other) {
    if (identical(this, other)) return true;

    return other.id == id && other.status == status;
  }

  @override
  int get hashCode => id.hashCode ^ status.hashCode;
}
