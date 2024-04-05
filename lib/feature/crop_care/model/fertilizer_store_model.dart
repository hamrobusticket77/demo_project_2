// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:krishi_hub/common/model/photos.dart';

class FertilizerStoreModel {
  final String id;
  final String type;
  final String name;
  final String address;
  final String email;
  List<String> phoneNumber;

  List<ContactPerson> contactPersons;
  List<Product> products;
  List<Photos> media;
  FertilizerStoreModel({
    required this.id,
    required this.type,
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.contactPersons,
    required this.products,
    required this.media,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'name': name,
      'address': address,
      'email': email,
      'phoneNumber': phoneNumber,
      'contactPersons': contactPersons.map((x) => x.toMap()).toList(),
      'products': products.map((x) => x.toMap()).toList(),
      'media': media.map((x) => x.toMap()).toList(),
    };
  }

  factory FertilizerStoreModel.fromMap(Map<String, dynamic> map) {
    return FertilizerStoreModel(
      id: map['id'] ?? "",
      type: map['type'] ?? "",
      name: map['name'] ?? "",
      address: map['address'] ?? "",
      email: map['email'] ?? "",
      phoneNumber: (map['phoneNumber'] is String)
          ? [map['phoneNumber']]
          : List<String>.from(map['phoneNumber'] ?? []),
      contactPersons: List.from(map['contactPersons'] ?? [])
          .map((e) => ContactPerson.fromMap(e))
          .toList(),
      products: List.from(map['products'] ?? [])
          .map((e) => Product.fromMap(e))
          .toList(),
      media:
          List.from(map['media'] ?? []).map((e) => Photos.fromMap(e)).toList(),
    );
  }

  FertilizerStoreModel copyWith({
    String? id,
    String? type,
    String? name,
    String? address,
    String? email,
    List<String>? phoneNumber,
    List<ContactPerson>? contactPersons,
    List<Product>? products,
    List<Photos>? media,
  }) {
    return FertilizerStoreModel(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      address: address ?? this.address,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      contactPersons: contactPersons ?? this.contactPersons,
      products: products ?? this.products,
      media: media ?? this.media,
    );
  }

  @override
  String toString() {
    return 'FertilizerStoreModel(id: $id, type: $type, name: $name, address: $address, email: $email, phoneNumber: $phoneNumber, contactPersons: $contactPersons, products: $products, media: $media)';
  }

  @override
  bool operator ==(covariant FertilizerStoreModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.type == type &&
        other.name == name &&
        other.address == address &&
        other.email == email &&
        listEquals(other.phoneNumber, phoneNumber) &&
        listEquals(other.contactPersons, contactPersons) &&
        listEquals(other.products, products) &&
        listEquals(other.media, media);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        name.hashCode ^
        address.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        contactPersons.hashCode ^
        products.hashCode ^
        media.hashCode;
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

class Product {
  final String id;
  final String createdAt;
  final String title;
  final Category category;
  Product({
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

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      title: map['title'] ?? "",
      category: Category.fromMap(map['category'] ?? {}),
    );
  }

  Product copyWith({
    String? id,
    String? createdAt,
    String? title,
    Category? category,
  }) {
    return Product(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      category: category ?? this.category,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, createdAt: $createdAt, title: $title, category: $category)';
  }

  @override
  bool operator ==(covariant Product other) {
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
