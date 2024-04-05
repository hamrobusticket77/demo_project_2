// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:krishi_hub/common/model/photos.dart';

class CurrentMarketPriceModel {
  final String id;
  final String name;
  final String address;
  final String email;
  List<String> phoneNumber;
  List<Photos> media;
  List<Products> products;
  List<ContactPerson> contactPersons;
  CurrentMarketPriceModel({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.media,
    required this.products,
    required this.contactPersons,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'email': email,
      'phoneNumber': phoneNumber,
      'media': media.map((x) => x.toMap()).toList(),
      'products': products.map((x) => x.toMap()).toList(),
      'contactPersons': contactPersons.map((x) => x.toMap()).toList(),
    };
  }

  factory CurrentMarketPriceModel.fromMap(Map<String, dynamic> map) {
    return CurrentMarketPriceModel(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      address: map['address'] ?? "",
      email: map['email'] ?? "",
      phoneNumber: (map['phoneNumber'] is String)
          ? [map['phoneNumber']]
          : List<String>.from(map['phoneNumber'] ?? []),
      media:
          List.from(map['media'] ?? []).map((e) => Photos.fromMap(e)).toList(),
      products: List.from(map['products'] ?? [])
          .map((e) => Products.fromMap(e))
          .toList(),
      contactPersons: List.from(map['contactPersons'] ?? [])
          .map((e) => ContactPerson.fromMap(e))
          .toList(),
    );
  }

  CurrentMarketPriceModel copyWith({
    String? id,
    String? name,
    String? address,
    String? email,
    List<String>? phoneNumber,
    List<Photos>? media,
    List<Products>? products,
    List<ContactPerson>? contactPersons,
  }) {
    return CurrentMarketPriceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      media: media ?? this.media,
      products: products ?? this.products,
      contactPersons: contactPersons ?? this.contactPersons,
    );
  }

  @override
  String toString() {
    return 'CurrentMarketPriceModel(id: $id, name: $name, address: $address, email: $email, phoneNumber: $phoneNumber, media: $media, products: $products, contactPersons: $contactPersons)';
  }

  @override
  bool operator ==(covariant CurrentMarketPriceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.address == address &&
        other.email == email &&
        listEquals(other.phoneNumber, phoneNumber) &&
        listEquals(other.media, media) &&
        listEquals(other.products, products) &&
        listEquals(other.contactPersons, contactPersons);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        address.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        media.hashCode ^
        products.hashCode ^
        contactPersons.hashCode;
  }
}

class ContactPerson {
  final String id;
  final String createdAt;
  final String name;
  final String phoneNumber;
  ContactPerson({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }

  factory ContactPerson.fromMap(Map<String, dynamic> map) {
    return ContactPerson(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      name: map['name'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
    );
  }

  ContactPerson copyWith({
    String? id,
    String? createdAt,
    String? name,
    String? phoneNumber,
  }) {
    return ContactPerson(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  String toString() {
    return 'ContactPerson(id: $id, createdAt: $createdAt, name: $name, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(covariant ContactPerson other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.name == name &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        name.hashCode ^
        phoneNumber.hashCode;
  }
}

class Products {
  final String id;
  final String createdAt;
  final String title;
  final Category category;
  Products({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'title': title,
      'category': category.toMap(),
    };
  }

  factory Products.fromMap(Map<String, dynamic> map) {
    return Products(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      title: map['title'] ?? "",
      category: Category.fromMap(map['category'] ?? {}),
    );
  }

  Products copyWith({
    String? id,
    String? createdAt,
    String? title,
    Category? category,
  }) {
    return Products(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      category: category ?? this.category,
    );
  }

  @override
  String toString() {
    return 'Products(id: $id, createdAt: $createdAt, title: $title, category: $category)';
  }

  @override
  bool operator ==(covariant Products other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.title == title &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        title.hashCode ^
        category.hashCode;
  }
}

class Category {
  final String id;
  final String createdAt;
  final String type;
  final String title;
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
