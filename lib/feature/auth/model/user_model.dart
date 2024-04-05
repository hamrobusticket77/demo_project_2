// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:krishi_hub/common/model/media_model.dart';
import 'package:krishi_hub/common/model/multi_language.dart';

class UserModel {
  final String id;
  final MultiLanguage firstName;
  final MultiLanguage? middleName;
  final MultiLanguage lastName;
  final String gender;
  final String phoneNumber;
  final String dateOfBirth;
  final String academicQualification;
  final String literateLevel;
  final int ward;
  final String village;
  final String farmVillage;
  final int farmWard;
  final String citizenshipNumber;
  final String citizenshipIssuedDistrict;
  final String? citizenshipIssuedDate;
  final String agricultureArea;
  final String agricultureSubArea;
  final bool isOwnLand;
  final LandArea landArea;
  final YearlyTurnOver yearlyTurnOver;
  final String averageMonthEngageOnAgriculture;
  final String farmerCategory;
  final MediaModel profileMedia;
  final int certificateNumber;
  final dynamic group;
  UserModel({
    required this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.gender,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.academicQualification,
    required this.literateLevel,
    required this.ward,
    required this.village,
    required this.farmVillage,
    required this.farmWard,
    required this.citizenshipNumber,
    required this.citizenshipIssuedDistrict,
    this.citizenshipIssuedDate,
    required this.agricultureArea,
    required this.agricultureSubArea,
    required this.isOwnLand,
    required this.landArea,
    required this.yearlyTurnOver,
    required this.averageMonthEngageOnAgriculture,
    required this.farmerCategory,
    required this.profileMedia,
    required this.certificateNumber,
    required this.group,
  });

  UserModel copyWith({
    String? id,
    MultiLanguage? firstName,
    MultiLanguage? middleName,
    MultiLanguage? lastName,
    String? gender,
    String? phoneNumber,
    String? dateOfBirth,
    String? academicQualification,
    String? literateLevel,
    int? ward,
    String? village,
    String? farmVillage,
    int? farmWard,
    String? citizenshipNumber,
    String? citizenshipIssuedDistrict,
    String? citizenshipIssuedDate,
    String? agricultureArea,
    String? agricultureSubArea,
    bool? isOwnLand,
    LandArea? landArea,
    YearlyTurnOver? yearlyTurnOver,
    String? averageMonthEngageOnAgriculture,
    String? farmerCategory,
    MediaModel? profileMedia,
    int? certificateNumber,
    dynamic group,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      academicQualification:
          academicQualification ?? this.academicQualification,
      literateLevel: literateLevel ?? this.literateLevel,
      ward: ward ?? this.ward,
      village: village ?? this.village,
      farmVillage: farmVillage ?? this.farmVillage,
      farmWard: farmWard ?? this.farmWard,
      citizenshipNumber: citizenshipNumber ?? this.citizenshipNumber,
      citizenshipIssuedDistrict:
          citizenshipIssuedDistrict ?? this.citizenshipIssuedDistrict,
      citizenshipIssuedDate:
          citizenshipIssuedDate ?? this.citizenshipIssuedDate,
      agricultureArea: agricultureArea ?? this.agricultureArea,
      agricultureSubArea: agricultureSubArea ?? this.agricultureSubArea,
      isOwnLand: isOwnLand ?? this.isOwnLand,
      landArea: landArea ?? this.landArea,
      yearlyTurnOver: yearlyTurnOver ?? this.yearlyTurnOver,
      averageMonthEngageOnAgriculture: averageMonthEngageOnAgriculture ??
          this.averageMonthEngageOnAgriculture,
      farmerCategory: farmerCategory ?? this.farmerCategory,
      profileMedia: profileMedia ?? this.profileMedia,
      certificateNumber: certificateNumber ?? this.certificateNumber,
      group: group ?? this.group,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName.toJson(),
      'middleName': middleName?.toJson(),
      'lastName': lastName.toJson(),
      'gender': gender,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'academicQualification': academicQualification,
      'literateLevel': literateLevel,
      'ward': ward,
      'village': village,
      'farmVillage': farmVillage,
      'farmWard': farmWard,
      'citizenshipNumber': citizenshipNumber,
      'citizenshipIssuedDistrict': citizenshipIssuedDistrict,
      'citizenshipIssuedDate': citizenshipIssuedDate,
      'agricultureArea': agricultureArea,
      'agricultureSubArea': agricultureSubArea,
      'isOwnLand': isOwnLand,
      'landArea': landArea.toMap(),
      'yearlyTurnOver': yearlyTurnOver.toMap(),
      'averageMonthEngageOnAgriculture': averageMonthEngageOnAgriculture,
      'farmerCategory': farmerCategory,
      'profileMedia': profileMedia.toMap(),
      'certificateNumber': certificateNumber,
      'group': group,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? "",
      firstName: MultiLanguage.fromJson(map['firstName'] ?? {}),
      middleName: map['middleName'] != null
          ? MultiLanguage.fromJson(map['middleName'] ?? {})
          : null,
      lastName: MultiLanguage.fromJson(map['lastName'] ?? {}),
      gender: map['gender'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      dateOfBirth: map['dateOfBirth'] ?? "",
      academicQualification: map['academicQualification'] ?? "",
      literateLevel: map['literateLevel'] ?? "",
      ward: map['ward'] ?? 0,
      village: map['village'] ?? "",
      farmVillage: map['farmVillage'] ?? "",
      farmWard: map['farmWard'] ?? -1,
      citizenshipNumber: map['citizenshipNumber'] ?? "",
      citizenshipIssuedDistrict: map['citizenshipIssuedDistrict'] ?? "",
      citizenshipIssuedDate: map['citizenshipIssuedDate'] != null
          ? map['citizenshipIssuedDate'] ?? ""
          : null,
      agricultureArea: map['agricultureArea'] ?? "",
      agricultureSubArea: map['agricultureSubArea'] ?? "",
      isOwnLand: map['isOwnLand'] ?? false,
      landArea: LandArea.fromMap(map['landArea'] ?? {}),
      yearlyTurnOver: YearlyTurnOver.fromMap(map['yearlyTurnOver'] ?? {}),
      averageMonthEngageOnAgriculture:
          map['averageMonthEngageOnAgriculture'] ?? "",
      farmerCategory: map['farmerCategory'] ?? "",
      profileMedia: MediaModel.fromMap(map['profileMedia'] ?? {}),
      certificateNumber: map['certificateNumber'] ?? -1,
      group: map['group'],
    );
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.middleName == middleName &&
        other.lastName == lastName &&
        other.gender == gender &&
        other.phoneNumber == phoneNumber &&
        other.dateOfBirth == dateOfBirth &&
        other.academicQualification == academicQualification &&
        other.literateLevel == literateLevel &&
        other.ward == ward &&
        other.village == village &&
        other.farmVillage == farmVillage &&
        other.farmWard == farmWard &&
        other.citizenshipNumber == citizenshipNumber &&
        other.citizenshipIssuedDistrict == citizenshipIssuedDistrict &&
        other.citizenshipIssuedDate == citizenshipIssuedDate &&
        other.agricultureArea == agricultureArea &&
        other.agricultureSubArea == agricultureSubArea &&
        other.isOwnLand == isOwnLand &&
        other.landArea == landArea &&
        other.yearlyTurnOver == yearlyTurnOver &&
        other.averageMonthEngageOnAgriculture ==
            averageMonthEngageOnAgriculture &&
        other.farmerCategory == farmerCategory &&
        other.profileMedia == profileMedia &&
        other.certificateNumber == certificateNumber &&
        other.group == group;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        middleName.hashCode ^
        lastName.hashCode ^
        gender.hashCode ^
        phoneNumber.hashCode ^
        dateOfBirth.hashCode ^
        academicQualification.hashCode ^
        literateLevel.hashCode ^
        ward.hashCode ^
        village.hashCode ^
        farmVillage.hashCode ^
        farmWard.hashCode ^
        citizenshipNumber.hashCode ^
        citizenshipIssuedDistrict.hashCode ^
        citizenshipIssuedDate.hashCode ^
        agricultureArea.hashCode ^
        agricultureSubArea.hashCode ^
        isOwnLand.hashCode ^
        landArea.hashCode ^
        yearlyTurnOver.hashCode ^
        averageMonthEngageOnAgriculture.hashCode ^
        farmerCategory.hashCode ^
        profileMedia.hashCode ^
        certificateNumber.hashCode ^
        group.hashCode;
  }
}

class LandArea {
  final String biggha;
  final String katha;
  final String dhur;
  LandArea({
    required this.biggha,
    required this.katha,
    required this.dhur,
  });

  LandArea copyWith({
    String? biggha,
    String? katha,
    String? dhur,
  }) {
    return LandArea(
      biggha: biggha ?? this.biggha,
      katha: katha ?? this.katha,
      dhur: dhur ?? this.dhur,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'biggha': biggha,
      'katha': katha,
      'dhur': dhur,
    };
  }

  factory LandArea.fromMap(Map<String, dynamic> map) {
    return LandArea(
      biggha: map['biggha'] ?? "",
      katha: map['katha'] ?? "",
      dhur: map['dhur'] ?? "",
    );
  }

  @override
  bool operator ==(covariant LandArea other) {
    if (identical(this, other)) return true;

    return other.biggha == biggha && other.katha == katha && other.dhur == dhur;
  }

  @override
  int get hashCode => biggha.hashCode ^ katha.hashCode ^ dhur.hashCode;
}

class YearlyTurnOver {
  final int agriculture;
  final int nonAgriculture;
  final int total;
  YearlyTurnOver({
    required this.agriculture,
    required this.nonAgriculture,
    required this.total,
  });

  YearlyTurnOver copyWith({
    int? agriculture,
    int? nonAgriculture,
    int? total,
  }) {
    return YearlyTurnOver(
      agriculture: agriculture ?? this.agriculture,
      nonAgriculture: nonAgriculture ?? this.nonAgriculture,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'agriculture': agriculture,
      'nonAgriculture': nonAgriculture,
      'total': total,
    };
  }

  factory YearlyTurnOver.fromMap(Map<String, dynamic> map) {
    return YearlyTurnOver(
      agriculture: map['agriculture'] ?? 0,
      nonAgriculture: map['nonAgriculture'] ?? 0,
      total: map['total'] ?? 0,
    );
  }

  @override
  bool operator ==(covariant YearlyTurnOver other) {
    if (identical(this, other)) return true;

    return other.agriculture == agriculture &&
        other.nonAgriculture == nonAgriculture &&
        other.total == total;
  }

  @override
  int get hashCode =>
      agriculture.hashCode ^ nonAgriculture.hashCode ^ total.hashCode;
}
