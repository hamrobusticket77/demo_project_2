import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/model/photos.dart';
part 'employee_model.g.dart';

@HiveType(typeId: 46)
class EmployeeModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  dynamic deletedAt;
  @HiveField(2)
  String firstName;
  @HiveField(3)
  String middleName;
  @HiveField(4)
  String lastName;
  @HiveField(5)
  String phoneNumber;
  @HiveField(6)
  String email;
  @HiveField(7)
  bool isMunicipality;
  @HiveField(8)
  dynamic ward;
  @HiveField(9)
  Department designation;
  @HiveField(10)
  Department position;
  @HiveField(11)
  Department department;
  @HiveField(12)
  List<Photos> media;

  EmployeeModel({
    required this.id,
    required this.deletedAt,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.isMunicipality,
    required this.ward,
    required this.designation,
    required this.position,
    required this.department,
    required this.media,
  });

  EmployeeModel copyWith({
    String? id,
    DateTime? createdAt,
    dynamic deletedAt,
    String? firstName,
    String? middleName,
    String? lastName,
    String? phoneNumber,
    String? email,
    bool? isMunicipality,
    dynamic ward,
    Department? designation,
    Department? position,
    Department? department,
    List<Photos>? media,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      deletedAt: deletedAt ?? this.deletedAt,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      isMunicipality: isMunicipality ?? this.isMunicipality,
      ward: ward ?? this.ward,
      designation: designation ?? this.designation,
      position: position ?? this.position,
      department: department ?? this.department,
      media: media ?? this.media,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'deletedAt': deletedAt,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'isMunicipality': isMunicipality,
      'ward': ward,
      'designation': designation.toMap(),
      'position': position.toMap(),
      'department': department.toMap(),
      'media': media.map((x) => x.toMap()).toList(),
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      id: map['id'] as String,
      deletedAt: map['deletedAt'] as dynamic,
      firstName: map['firstName'] ?? "",
      middleName: map['middleName'] ?? "",
      lastName: map['lastName'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      email: map['email'] ?? "",
      isMunicipality: map['isMunicipality'] ?? false,
      ward: map['ward'] as dynamic,
      designation: Department.fromMap(map['designation'] ?? {}),
      position: Department.fromMap(map['position'] ?? {}),
      department: Department.fromMap(map['department'] ?? {}),
      media: (map['media'] as List<dynamic>)
          .map<Photos>((x) => Photos.fromMap(x ?? {}))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeModel.fromJson(String source) =>
      EmployeeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant EmployeeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.deletedAt == deletedAt &&
        other.firstName == firstName &&
        other.middleName == middleName &&
        other.lastName == lastName &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        other.isMunicipality == isMunicipality &&
        other.ward == ward &&
        other.designation == designation &&
        other.position == position &&
        other.department == department &&
        listEquals(other.media, media);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        deletedAt.hashCode ^
        firstName.hashCode ^
        middleName.hashCode ^
        lastName.hashCode ^
        phoneNumber.hashCode ^
        email.hashCode ^
        isMunicipality.hashCode ^
        ward.hashCode ^
        designation.hashCode ^
        position.hashCode ^
        department.hashCode ^
        media.hashCode;
  }
}

@HiveType(typeId: 47)
class Department {
  @HiveField(0)
  String id;
  @HiveField(1)
  dynamic deletedAt;
  @HiveField(2)
  String name;

  Department({
    required this.id,
    required this.deletedAt,
    required this.name,
  });

  Department copyWith({
    String? id,
    DateTime? createdAt,
    dynamic deletedAt,
    String? name,
  }) {
    return Department(
      id: id ?? this.id,
      deletedAt: deletedAt ?? this.deletedAt,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'deletedAt': deletedAt,
      'name': name,
    };
  }

  factory Department.fromMap(Map<String, dynamic> map) {
    return Department(
      id: map['id'] as String,
      deletedAt: map['deletedAt'] as dynamic,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Department.fromJson(String source) =>
      Department.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Department other) {
    if (identical(this, other)) return true;

    return other.id == id && other.deletedAt == deletedAt && other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ deletedAt.hashCode ^ name.hashCode;
  }
}
