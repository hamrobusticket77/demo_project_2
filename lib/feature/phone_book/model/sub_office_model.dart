import 'package:krishi_hub/feature/phone_book/model/office_model.dart';

class SubofficeModel {
  final String id;
  final String createdAt;
  final String title;
  final OfficeModel office;
  SubofficeModel({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.office,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'title': title,
      'office': office.toMap(),
    };
  }

  factory SubofficeModel.fromMap(Map<String, dynamic> map) {
    return SubofficeModel(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      title: map['title'] ?? "",
      office: OfficeModel.fromMap(map['office'] ?? {}),
    );
  }

  SubofficeModel copyWith({
    String? id,
    String? createdAt,
    String? title,
    OfficeModel? office,
  }) {
    return SubofficeModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      office: office ?? this.office,
    );
  }

  @override
  String toString() {
    return 'SubofficeModel(id: $id, createdAt: $createdAt, title: $title, office: $office)';
  }

  @override
  bool operator ==(covariant SubofficeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.title == title &&
        other.office == office;
  }

  @override
  int get hashCode {
    return id.hashCode ^ createdAt.hashCode ^ title.hashCode ^ office.hashCode;
  }
}
