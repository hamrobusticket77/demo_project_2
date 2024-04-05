import 'dart:convert';

class CategoryModel {
  final String id;
  final String createAt;
  final String? deletedAt;
  final String type;
  final String title;
  CategoryModel({
    required this.id,
    required this.createAt,
    this.deletedAt,
    required this.type,
    required this.title,
  });

  CategoryModel copyWith({
    String? id,
    String? createAt,
    String? deletedAt,
    String? type,
    String? title,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      createAt: createAt ?? this.createAt,
      deletedAt: deletedAt ?? this.deletedAt,
      type: type ?? this.type,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createAt': createAt,
      'deletedAt': deletedAt,
      'type': type,
      'title': title,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? "",
      createAt: map['createAt'] ?? "",
      deletedAt: map['deletedAt'] != null ? map['deletedAt'] ?? "" : null,
      type: map['type'] ?? "",
      title: map['title'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategoryModel(id: $id, createAt: $createAt, deletedAt: $deletedAt, type: $type, title: $title)';
  }

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createAt == createAt &&
        other.deletedAt == deletedAt &&
        other.type == type &&
        other.title == title;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createAt.hashCode ^
        deletedAt.hashCode ^
        type.hashCode ^
        title.hashCode;
  }
}
