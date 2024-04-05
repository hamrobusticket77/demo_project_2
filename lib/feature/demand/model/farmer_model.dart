import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';

part 'farmer_model.g.dart';

@HiveType(typeId: 25)
class FarmerModel {
  @HiveField(0)
  final String id;
  @HiveField(2)
  final FarmerInfo farmerPersonalInformation;
  FarmerModel({
    required this.id,
    required this.farmerPersonalInformation,
  });

  FarmerModel copyWith({
    String? id,
    FarmerInfo? farmerPersonalInformation,
  }) {
    return FarmerModel(
      id: id ?? this.id,
      farmerPersonalInformation:
          farmerPersonalInformation ?? this.farmerPersonalInformation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'farmerPersonalInformation': farmerPersonalInformation.toMap(),
    };
  }

  factory FarmerModel.fromMap(Map<String, dynamic> map) {
    return FarmerModel(
      id: map['id'] ?? "",
      farmerPersonalInformation:
          FarmerInfo.fromMap(map['farmerPersonalInformation'] ?? {}),
    );
  }

  @override
  bool operator ==(covariant FarmerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.farmerPersonalInformation == farmerPersonalInformation;
  }

  @override
  int get hashCode => id.hashCode ^ farmerPersonalInformation.hashCode;
}

@HiveType(typeId: 26)
class FarmerInfo {
  @HiveField(0)
  final MultiLanguage firstName;
  @HiveField(1)
  final MultiLanguage? middleName;
  @HiveField(2)
  final MultiLanguage lastName;
  FarmerInfo({
    required this.firstName,
    this.middleName,
    required this.lastName,
  });

  FarmerInfo copyWith({
    MultiLanguage? firstName,
    MultiLanguage? middleName,
    MultiLanguage? lastName,
  }) {
    return FarmerInfo(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName.toJson(),
      'middleName': middleName?.toJson(),
      'lastName': lastName.toJson(),
    };
  }

  factory FarmerInfo.fromMap(Map<String, dynamic> map) {
    return FarmerInfo(
      firstName: MultiLanguage.fromJson(map['firstName'] ?? {}),
      middleName: map['middleName'] != null
          ? MultiLanguage.fromJson(map['middleName'] ?? {})
          : null,
      lastName: MultiLanguage.fromJson(map['lastName'] ?? {}),
    );
  }

  @override
  bool operator ==(covariant FarmerInfo other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.middleName == middleName &&
        other.lastName == lastName;
  }

  @override
  int get hashCode =>
      firstName.hashCode ^ middleName.hashCode ^ lastName.hashCode;

  String get getFullFarmerName {
    String englishName = "";
    String nepaliName = "";
    nepaliName =
        "${firstName.ne ?? ""} ${middleName?.ne ?? ""} ${lastName.ne ?? ""}";
    englishName = "${firstName.en} ${middleName?.en ?? ""} ${lastName.en}";
    if (CheckLocal.isEnglish()) {
      return englishName.capitalize();
    } else {
      if (nepaliName.trim().isNotEmpty) {
        return nepaliName;
      }
    }
    return englishName.capitalize();
  }
}
