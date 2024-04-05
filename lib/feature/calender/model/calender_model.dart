import 'package:flutter/foundation.dart';
import 'package:krishi_hub/common/model/photos.dart';
import 'package:krishi_hub/feature/product/model/crop_type_model.dart';

class CalenderModel {
  final String id;
  final CropTypeModel category;
  final CropTypeModel name;
  final Photos media;
  final List<Information> information;
  CalenderModel({
    required this.id,
    required this.category,
    required this.name,
    required this.media,
    required this.information,
  });

  CalenderModel copyWith({
    String? id,
    CropTypeModel? category,
    CropTypeModel? name,
    Photos? media,
    List<Information>? information,
  }) {
    return CalenderModel(
      id: id ?? this.id,
      category: category ?? this.category,
      name: name ?? this.name,
      media: media ?? this.media,
      information: information ?? this.information,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category.toMap(),
      'name': name.toMap(),
      'media': media.toMap(),
      'information': information.map((x) => x.toMap()).toList(),
    };
  }

  factory CalenderModel.fromMap(Map<String, dynamic> map) {
    return CalenderModel(
      id: map['id'] ?? "",
      category: CropTypeModel.fromMap(map['category'] ?? {}),
      name: CropTypeModel.fromMap(map['name'] ?? {}),
      media: Photos.fromMap(map['media'] ?? {}),
      information: List.from(map['information'])
          .map((e) => Information.fromMap(e))
          .toList(),
    );
  }

  @override
  bool operator ==(covariant CalenderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.category == category &&
        other.name == name &&
        other.media == media &&
        listEquals(other.information, information);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        category.hashCode ^
        name.hashCode ^
        media.hashCode ^
        information.hashCode;
  }
}

class Information {
  final InfoDetails harvestTime;
  final InfoDetails sowingTime;
  final InfoDetails growingTime;
  final String ecologicalArea;
  Information({
    required this.harvestTime,
    required this.sowingTime,
    required this.growingTime,
    required this.ecologicalArea,
  });

  Information copyWith({
    InfoDetails? harvestTime,
    InfoDetails? sowingTime,
    InfoDetails? growingTime,
    String? ecologicalArea,
  }) {
    return Information(
      harvestTime: harvestTime ?? this.harvestTime,
      sowingTime: sowingTime ?? this.sowingTime,
      growingTime: growingTime ?? this.growingTime,
      ecologicalArea: ecologicalArea ?? this.ecologicalArea,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'harvestTime': harvestTime.toMap(),
      'sowingTime': sowingTime.toMap(),
      'growingTime': growingTime.toMap(),
      'ecologicalArea': ecologicalArea,
    };
  }

  factory Information.fromMap(Map<String, dynamic> map) {
    return Information(
      harvestTime: InfoDetails.fromMap(map['harvestTime'] ?? {}),
      sowingTime: InfoDetails.fromMap(map['sowingTime'] ?? {}),
      growingTime: InfoDetails.fromMap(map['growingTime'] ?? {}),
      ecologicalArea: map['ecologicalArea'] ?? "",
    );
  }

  @override
  bool operator ==(covariant Information other) {
    if (identical(this, other)) return true;

    return other.harvestTime == harvestTime &&
        other.sowingTime == sowingTime &&
        other.growingTime == growingTime &&
        other.ecologicalArea == ecologicalArea;
  }

  @override
  int get hashCode {
    return harvestTime.hashCode ^
        sowingTime.hashCode ^
        growingTime.hashCode ^
        ecologicalArea.hashCode;
  }
}

class InfoDetails {
  final String startMonth;
  final String endMonth;
  InfoDetails({
    required this.startMonth,
    required this.endMonth,
  });

  InfoDetails copyWith({
    String? startMonth,
    String? endMonth,
  }) {
    return InfoDetails(
      startMonth: startMonth ?? this.startMonth,
      endMonth: endMonth ?? this.endMonth,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startMonth': startMonth,
      'endMonth': endMonth,
    };
  }

  factory InfoDetails.fromMap(Map<String, dynamic> map) {
    return InfoDetails(
      startMonth: map['startMonth'] ?? "",
      endMonth: map['endMonth'] ?? "",
    );
  }

  @override
  bool operator ==(covariant InfoDetails other) {
    if (identical(this, other)) return true;

    return other.startMonth == startMonth && other.endMonth == endMonth;
  }

  @override
  int get hashCode => startMonth.hashCode ^ endMonth.hashCode;
}
