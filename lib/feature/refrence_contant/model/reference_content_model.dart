// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/common/model/photos.dart';

class ReferenceContentModel {
  final String id;
  final String createdAt;
  final String title;
  final String description;
  final bool isPublished;
  final Details details;
  ReferenceContentModel({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.description,
    required this.isPublished,
    required this.details,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'title': title,
      'description': description,
      'isPublished': isPublished,
      'details': details.toMap(),
    };
  }

  factory ReferenceContentModel.fromMap(Map<String, dynamic> map) {
    return ReferenceContentModel(
      id: map['id'] ?? 0 - 0,
      createdAt: map['createdAt'] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      isPublished: map['isPublished'] ?? false,
      details: Details.fromMap(map['details'] ?? {}),
    );
  }

  ReferenceContentModel copyWith({
    String? id,
    String? createdAt,
    DateTime? deletedAt,
    String? title,
    String? description,
    bool? isPublished,
    Details? details,
  }) {
    return ReferenceContentModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      description: description ?? this.description,
      isPublished: isPublished ?? this.isPublished,
      details: details ?? this.details,
    );
  }

  @override
  String toString() {
    return 'ReferenceContentModel(id: $id, createdAt: $createdAt,  title: $title, description: $description, isPublished: $isPublished, details: $details)';
  }

  @override
  bool operator ==(covariant ReferenceContentModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.title == title &&
        other.description == description &&
        other.isPublished == isPublished &&
        other.details == details;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        title.hashCode ^
        description.hashCode ^
        isPublished.hashCode ^
        details.hashCode;
  }
}

class Details {
  final String id;
  final String createdAt;
  final MultiLanguage firstName;
  final MultiLanguage? middleName;
  final MultiLanguage lastName;
  final String? phoneNumber;
  List<Photos> profileImage;
  Details({
    required this.id,
    required this.createdAt,
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.phoneNumber,
    required this.profileImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'firstName': firstName.toJson(),
      'middleName': middleName?.toJson(),
      'lastName': lastName.toJson(),
      'phoneNumber': phoneNumber,
      'profileImage': profileImage.map((x) => x.toMap()).toList(),
    };
  }

  factory Details.fromMap(Map<String, dynamic> map) {
    return Details(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      firstName: MultiLanguage.fromJson(map['firstName'] ?? {}),
      middleName: map['middleName'] != null
          ? MultiLanguage.fromJson(map['middleName'] ?? {})
          : null,
      lastName: MultiLanguage.fromJson(map['lastName'] ?? {}),
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] ?? "" : null,
      profileImage: List.from(map['profileImage'] ?? [])
          .map((e) => Photos.fromMap(e))
          .toList(),
    );
  }

  Details copyWith({
    String? id,
    String? createdAt,
    MultiLanguage? firstName,
    MultiLanguage? middleName,
    MultiLanguage? lastName,
    String? phoneNumber,
    List<Photos>? profileImage,
  }) {
    return Details(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  @override
  String toString() {
    return 'Details(id: $id, createdAt: $createdAt, firstName: $firstName, middleName: $middleName, lastName: $lastName, phoneNumber: $phoneNumber, profileImage: $profileImage)';
  }

  @override
  bool operator ==(covariant Details other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.firstName == firstName &&
        other.middleName == middleName &&
        other.lastName == lastName &&
        other.phoneNumber == phoneNumber &&
        listEquals(other.profileImage, profileImage);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        firstName.hashCode ^
        middleName.hashCode ^
        lastName.hashCode ^
        phoneNumber.hashCode ^
        profileImage.hashCode;
  }
}
