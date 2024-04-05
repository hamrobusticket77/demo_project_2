import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/model/photos.dart';
part 'media_model.g.dart';

@HiveType(typeId: 3)
class MediaModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String relatedTo;
  @HiveField(2)
  final List<Photos> medias;
  MediaModel({
    required this.id,
    required this.relatedTo,
    required this.medias,
  });

  MediaModel copyWith({
    int? id,
    String? relatedTo,
    List<Photos>? medias,
  }) {
    return MediaModel(
      id: id ?? this.id,
      relatedTo: relatedTo ?? this.relatedTo,
      medias: medias ?? this.medias,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'relatedTo': relatedTo,
      'medias': medias.map((x) => x.toMap()).toList(),
    };
  }

  factory MediaModel.fromMap(Map<String, dynamic> map) {
    return MediaModel(
        id: map['id'] ?? -1,
        relatedTo: map['relatedTo'] ?? "",
        medias: List.from(map['medias'] ?? [])
            .map((e) => Photos.fromMap(e))
            .toList());
  }

  @override
  bool operator ==(covariant MediaModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.relatedTo == relatedTo &&
        listEquals(other.medias, medias);
  }

  @override
  int get hashCode => id.hashCode ^ relatedTo.hashCode ^ medias.hashCode;
}
