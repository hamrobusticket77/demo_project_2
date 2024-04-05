// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SocialMedias {
  final String id;
  final String createdAt;
  final String type;
  final String url;
  SocialMedias({
    required this.id,
    required this.createdAt,
    required this.type,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'type': type,
      'url': url,
    };
  }

  factory SocialMedias.fromMap(Map<String, dynamic> map) {
    return SocialMedias(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      type: map['type'] ?? "",
      url: map['url'] ?? "",
    );
  }

  SocialMedias copyWith({
    String? id,
    String? createdAt,
    String? type,
    String? url,
  }) {
    return SocialMedias(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      url: url ?? this.url,
    );
  }

  @override
  String toString() {
    return 'SocialMedias(id: $id, createdAt: $createdAt, type: $type, url: $url)';
  }

  @override
  bool operator ==(covariant SocialMedias other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.type == type &&
        other.url == url;
  }

  @override
  int get hashCode {
    return id.hashCode ^ createdAt.hashCode ^ type.hashCode ^ url.hashCode;
  }
}
