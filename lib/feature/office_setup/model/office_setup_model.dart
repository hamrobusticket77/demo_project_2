// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'office_setup_model.g.dart';

@HiveType(typeId: 1)
class OfficeSetupModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String createdAt;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String fax;
  @HiveField(4)
  final String email;
  @HiveField(5)
  final String phoneNumber;
  @HiveField(6)
  final String callCenterNumber;
  @HiveField(7)
  final String telephone;
  @HiveField(8)
  final String address;
  OfficeSetupModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.fax,
    required this.email,
    required this.phoneNumber,
    required this.telephone,
    required this.address,
    required this.callCenterNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'name': name,
      'fax': fax,
      'email': email,
      'phoneNumber': phoneNumber,
      'telephone': telephone,
      'address': address,
      'callCenterNumber': callCenterNumber,
    };
  }

  factory OfficeSetupModel.fromMap(Map<String, dynamic> map) {
    return OfficeSetupModel(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      name: map['name'] ?? "",
      fax: map['fax'] ?? "",
      email: map['email'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      callCenterNumber: map['callCenterNumber'] ?? "",
      telephone: map['telephone'] ?? "",
      address: map['address'] ?? "",
    );
  }

  OfficeSetupModel copyWith({
    String? id,
    String? createdAt,
    String? name,
    String? fax,
    String? email,
    String? phoneNumber,
    String? telephone,
    String? address,
    String? callCenterNumber,
  }) {
    return OfficeSetupModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      fax: fax ?? this.fax,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      telephone: telephone ?? this.telephone,
      address: address ?? this.address,
      callCenterNumber: callCenterNumber ?? this.callCenterNumber,
    );
  }

  @override
  String toString() {
    return 'OfficeSetupModel(id: $id, createdAt: $createdAt, name: $name, fax: $fax, email: $email, phoneNumber: $phoneNumber, telephone: $telephone, address: $address)';
  }

  @override
  bool operator ==(covariant OfficeSetupModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.name == name &&
        other.fax == fax &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.telephone == telephone &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        name.hashCode ^
        fax.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        telephone.hashCode ^
        address.hashCode;
  }
}
