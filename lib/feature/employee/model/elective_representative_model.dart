import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/model/photos.dart';

part 'elective_representative_model.g.dart';

@HiveType(typeId: 48)
class ElectiveRepresentiveModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String middleName;
  @HiveField(3)
  final String lastName;
  @HiveField(4)
  final String phoneNumber;
  @HiveField(5)
  final String email;
  @HiveField(6)
  final String designation;
  @HiveField(7)
  final List<Photos> media;
  ElectiveRepresentiveModel({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.designation,
    // required this.Ward,
    required this.media,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'designation': designation,
      // 'ward': Ward,
      'media': media.map((x) => x.toMap()).toList(),
    };
  }

  factory ElectiveRepresentiveModel.fromMap(Map<String, dynamic> map) {
    return ElectiveRepresentiveModel(
      id: map['id'] ?? "",
      firstName: map['firstName'] ?? "",
      middleName: map['middleName'] ?? "",
      lastName: map['lastName'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      email: map['email'] ?? "",
      designation: map['designation'] ?? "",
      // Ward: map['ward'] ?? "",
      media: (map['media'] as List<dynamic>)
          .map<Photos>((x) => Photos.fromMap(x as Map<String, dynamic>))
          .toList(),
    );
  }

  ElectiveRepresentiveModel copyWith({
    String? id,
    String? firstName,
    String? middleName,
    String? lastName,
    String? phoneNumber,
    String? email,
    String? designation,
    String? ward,
    List<Photos>? media,
  }) {
    return ElectiveRepresentiveModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      designation: designation ?? this.designation,
      // Ward: ward ?? Ward,
      media: media ?? this.media,
    );
  }

  @override
  String toString() {
    return 'ElectiveRepresentiveModel(id: $id, firstName: $firstName, middleName: $middleName, lastName: $lastName, phoneNumber: $phoneNumber, email: $email, designation: $designation, media: $media)';
  }

  @override
  bool operator ==(covariant ElectiveRepresentiveModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.middleName == middleName &&
        other.lastName == lastName &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        other.designation == designation &&
        // other.Ward == Ward &&
        listEquals(other.media, media);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        middleName.hashCode ^
        lastName.hashCode ^
        phoneNumber.hashCode ^
        email.hashCode ^
        designation.hashCode ^
        // Ward.hashCode ^
        media.hashCode;
  }
}
