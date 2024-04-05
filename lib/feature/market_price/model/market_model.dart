import 'dart:convert';

class MarketModel {
  final String id;
  final String createdAt;
  final String? deletedAt;
  final String title;
  MarketModel({
    required this.id,
    required this.createdAt,
    this.deletedAt,
    required this.title,
  });

  MarketModel copyWith({
    String? id,
    String? createdAt,
    String? deletedAt,
    String? title,
  }) {
    return MarketModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'deletedAt': deletedAt,
      'title': title,
    };
  }

  factory MarketModel.fromMap(Map<String, dynamic> map) {
    return MarketModel(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      deletedAt: map['deletedAt'] != null ? map['deletedAt'] ?? "" : null,
      title: map['title'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory MarketModel.fromJson(String source) =>
      MarketModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MarketModel(id: $id, createdAt: $createdAt, deletedAt: $deletedAt, title: $title)';
  }

  @override
  bool operator ==(covariant MarketModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.deletedAt == deletedAt &&
        other.title == title;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        deletedAt.hashCode ^
        title.hashCode;
  }
}
