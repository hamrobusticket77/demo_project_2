// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:krishi_hub/feature/phone_book/model/contact_detail_model.dart';
import 'package:krishi_hub/feature/phone_book/model/departement_model.dart';
import 'package:krishi_hub/feature/phone_book/model/social_media_model.dart';

class OfficeModel {
  final String id;
  final String createdAt;
  final String title;
  final String email;
  final String websiteUrl;
  final DepartementModel department;
  List<ContactModel> contactDetails;
  List<SocialMedias> socialMedias;
  OfficeModel({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.email,
    required this.websiteUrl,
    required this.department,
    required this.contactDetails,
    required this.socialMedias,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'title': title,
      'email': email,
      'websiteUrl': websiteUrl,
      'department': department.toMap(),
      'contactDetails': contactDetails.map((x) => x.toMap()).toList(),
      'socialMedias': socialMedias.map((x) => x.toMap()).toList(),
    };
  }

  factory OfficeModel.fromMap(Map<String, dynamic> map) {
    return OfficeModel(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      title: map['title'] ?? "",
      email: map['email'] ?? "",
      websiteUrl: map['websiteUrl'] ?? "",
      department: DepartementModel.fromMap(map['department'] ?? {}),
      contactDetails: List.from(map['contactDetails'] ?? [])
          .map((e) => ContactModel.fromMap(e))
          .toList(),
      socialMedias: List.from(map['socialMedias'] ?? [])
          .map((e) => SocialMedias.fromMap(e))
          .toList(),
    );
  }

  OfficeModel copyWith({
    String? id,
    String? createdAt,
    String? title,
    String? email,
    String? websiteUrl,
    DepartementModel? department,
    List<ContactModel>? contactDetails,
    List<SocialMedias>? socialMedias,
  }) {
    return OfficeModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      email: email ?? this.email,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      department: department ?? this.department,
      contactDetails: contactDetails ?? this.contactDetails,
      socialMedias: socialMedias ?? this.socialMedias,
    );
  }

  @override
  String toString() {
    return 'OfficeModel(id: $id, createdAt: $createdAt, title: $title, email: $email, websiteUrl: $websiteUrl, department: $department, contactDetails: $contactDetails, socialMedias: $socialMedias)';
  }

  @override
  bool operator ==(covariant OfficeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.title == title &&
        other.email == email &&
        other.websiteUrl == websiteUrl &&
        other.department == department &&
        listEquals(other.contactDetails, contactDetails) &&
        listEquals(other.socialMedias, socialMedias);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        title.hashCode ^
        email.hashCode ^
        websiteUrl.hashCode ^
        department.hashCode ^
        contactDetails.hashCode ^
        socialMedias.hashCode;
  }
}
