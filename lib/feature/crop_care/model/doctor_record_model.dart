// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:krishi_hub/common/model/photos.dart';

class DoctorRecordModel {
  final String id;
  final String name;
  final String address;
  final String email;
  List<Sector> sector;
  List<Photos> media;
  List<String> phoneNumber;
  DoctorRecordModel({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.sector,
    required this.media,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'email': email,
      'sector': sector.map((x) => x.toMap()).toList(),
      'media': media.map((x) => x.toMap()).toList(),
      'phoneNumber': phoneNumber,
    };
  }

  factory DoctorRecordModel.fromMap(Map<String, dynamic> map) {
    return DoctorRecordModel(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      address: map['address'] ?? "",
      email: map['email'] ?? "",
      sector:
          List.from(map['sector'] ?? []).map((e) => Sector.fromMap(e)).toList(),
      media:
          List.from(map['media'] ?? []).map((e) => Photos.fromMap(e)).toList(),
      phoneNumber: (map['phoneNumber'] is String)
          ? [map['phoneNumber']]
          : List<String>.from(map['phoneNumber'] ?? []),
    );
  }

  DoctorRecordModel copyWith({
    String? id,
    String? name,
    String? address,
    String? email,
    List<Sector>? sector,
    List<Photos>? media,
    List<String>? phoneNumber,
  }) {
    return DoctorRecordModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      email: email ?? this.email,
      sector: sector ?? this.sector,
      media: media ?? this.media,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  String toString() {
    return 'DoctorRecordModel(id: $id, name: $name, address: $address, email: $email, sector: $sector, media: $media, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(covariant DoctorRecordModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.address == address &&
        other.email == email &&
        listEquals(other.sector, sector) &&
        listEquals(other.media, media) &&
        listEquals(other.phoneNumber, phoneNumber);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        address.hashCode ^
        email.hashCode ^
        sector.hashCode ^
        media.hashCode ^
        phoneNumber.hashCode;
  }
}

class Sector {
  String id;
  String createdAt;
  String yearOfExperience;
  Category category;
  Sector({
    required this.id,
    required this.createdAt,
    required this.category,
    required this.yearOfExperience,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'category': category.toMap(),
    };
  }

  factory Sector.fromMap(Map<String, dynamic> map) {
    return Sector(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      yearOfExperience: map['yearOfExperience'] ?? "",
      category: Category.fromMap(map['category'] ?? {}),
    );
  }

  Sector copyWith({
    String? id,
    String? createdAt,
    String? yearOfExperience,
    Category? category,
  }) {
    return Sector(
      id: id ?? this.id,
      yearOfExperience: yearOfExperience ?? this.yearOfExperience,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
    );
  }

  @override
  String toString() =>
      'Sector(id: $id, createdAt: $createdAt, category: $category)';

  @override
  bool operator ==(covariant Sector other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.category == category;
  }

  @override
  int get hashCode => id.hashCode ^ createdAt.hashCode ^ category.hashCode;
}

class Category {
  String id;
  String createdAt;
  String type;
  String title;
  Category({
    required this.id,
    required this.createdAt,
    required this.type,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'type': type,
      'title': title,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      type: map['type'] ?? "",
      title: map['title'] ?? "",
    );
  }

  Category copyWith({
    String? id,
    String? createdAt,
    String? type,
    String? title,
  }) {
    return Category(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      title: title ?? this.title,
    );
  }

  @override
  String toString() {
    return 'Category(id: $id, createdAt: $createdAt, type: $type, title: $title)';
  }

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.type == type &&
        other.title == title;
  }

  @override
  int get hashCode {
    return id.hashCode ^ createdAt.hashCode ^ type.hashCode ^ title.hashCode;
  }
}
