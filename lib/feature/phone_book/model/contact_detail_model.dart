// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ContactModel {
  final String id;
  final String createdAt;
  final String number;
  final String type;
  ContactModel({
    required this.id,
    required this.createdAt,
    required this.number,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'number': number,
      'type': type,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      number: map['number'] ?? "",
      type: map['type'] ?? "",
    );
  }

  ContactModel copyWith({
    String? id,
    String? createdAt,
    String? number,
    String? type,
  }) {
    return ContactModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      number: number ?? this.number,
      type: type ?? this.type,
    );
  }

  @override
  String toString() {
    return 'ContactModel(id: $id, createdAt: $createdAt, number: $number, type: $type)';
  }

  @override
  bool operator ==(covariant ContactModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.number == number &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^ createdAt.hashCode ^ number.hashCode ^ type.hashCode;
  }
}
