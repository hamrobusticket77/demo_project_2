// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';
part 'photos.g.dart';

@HiveType(typeId: 4)
class Photos {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String createdAt;
  @HiveField(2)
  final String fileName;
  @HiveField(3)
  final String type;
  @HiveField(4)
  final String path;
  @HiveField(5)
  Photos({
    required this.id,
    required this.createdAt,
    required this.fileName,
    required this.type,
    required this.path,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'fileName': fileName,
      'type': type,
      'path': path,
    };
  }

  factory Photos.fromMap(Map<String, dynamic> map) {
    return Photos(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      fileName: map['fileName'] ?? "",
      type: map['type'] ?? "",
      path: map['path'] ?? "",
    );
  }

  Photos copyWith({
    String? id,
    String? createdAt,
    String? fileName,
    String? type,
    String? path,
  }) {
    return Photos(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      fileName: fileName ?? this.fileName,
      type: type ?? this.type,
      path: path ?? this.path,
    );
  }

  @override
  String toString() {
    return 'Photos(id: $id, createdAt: $createdAt, fileName: $fileName, type: $type, path: $path)';
  }

  @override
  bool operator ==(covariant Photos other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.fileName == fileName &&
        other.type == type &&
        other.path == path;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        fileName.hashCode ^
        type.hashCode ^
        path.hashCode;
  }

  bool get isImage {
    String type = path.split(".").last;

    if (type == "jpg" || type == "png" || type == "jpeg") {
      return true;
    }
    return false;
  }

  bool get isDoc {
    String type = path.split(".").last;

    if (type == "doc" || type == "docx") {
      return true;
    }
    return false;
  }

  bool get isPdf {
    String type = path.split(".").last;

    if (type == "pdf") {
      return true;
    }
    return false;
  }
}
