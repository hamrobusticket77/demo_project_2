// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class OrganizationStructureModel {
    String id;

    DatumMedia media;
  OrganizationStructureModel({
    required this.id,
    required this.media,
  });

    


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'media': media.toMap(),
    };
  }

  factory OrganizationStructureModel.fromMap(Map<String, dynamic> map) {
    return OrganizationStructureModel(
      id: map['id'] as String,
      media: DatumMedia.fromMap(map['media'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrganizationStructureModel.fromJson(String source) => OrganizationStructureModel.fromMap(json.decode(source) as Map<String, dynamic>);

  OrganizationStructureModel copyWith({
    String? id,
    DatumMedia? media,
  }) {
    return OrganizationStructureModel(
      id: id ?? this.id,
      media: media ?? this.media,
    );
  }

  @override
  String toString() => 'OrganizationStructureModel(id: $id, media: $media)';

  @override
  bool operator ==(covariant OrganizationStructureModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.media == media;
  }

  @override
  int get hashCode => id.hashCode ^ media.hashCode;
}

class DatumMedia {
    int id;
    String relatedTo;
    List<MediaElement> medias;

    DatumMedia({
        required this.id,
        required this.relatedTo,
        required this.medias,
    });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'relatedTo': relatedTo,
      'medias': medias.map((x) => x.toMap()).toList(),
    };
  }

  factory DatumMedia.fromMap(Map<String, dynamic> map) {
    return DatumMedia(
      id: map['id'] as int,
      relatedTo: map['relatedTo'] as String,
      medias: List.from(map['medias']).map((e) => MediaElement.fromMap(e)).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DatumMedia.fromJson(String source) => DatumMedia.fromMap(json.decode(source) as Map<String, dynamic>);

  DatumMedia copyWith({
    int? id,
    String? relatedTo,
    List<MediaElement>? medias,
  }) {
    return DatumMedia(
      id: id ?? this.id,
      relatedTo: relatedTo ?? this.relatedTo,
      medias: medias ?? this.medias,
    );
  }

  @override
  String toString() => 'DatumMedia(id: $id, relatedTo: $relatedTo, medias: $medias)';

  @override
  bool operator ==(covariant DatumMedia other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.relatedTo == relatedTo &&
      listEquals(other.medias, medias);
  }

  @override
  int get hashCode => id.hashCode ^ relatedTo.hashCode ^ medias.hashCode;
}

class MediaElement {
    String id;
  
    String fileName;
    String type;
    String relatedTo;
    String path;
  MediaElement({
    required this.id,
    required this.fileName,
    required this.type,
    required this.relatedTo,
    required this.path,
  });

  


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fileName': fileName,
      'type': type,
      'relatedTo': relatedTo,
      'path': path,
    };
  }

  factory MediaElement.fromMap(Map<String, dynamic> map) {
    return MediaElement(
      id: map['id'] as String,
      fileName: map['fileName'] as String,
      type: map['type'] as String,
      relatedTo: map['relatedTo'] as String,
      path: map['path'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaElement.fromJson(String source) => MediaElement.fromMap(json.decode(source) as Map<String, dynamic>);

  MediaElement copyWith({
    String? id,
    String? fileName,
    String? type,
    String? relatedTo,
    String? path,
  }) {
    return MediaElement(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      type: type ?? this.type,
      relatedTo: relatedTo ?? this.relatedTo,
      path: path ?? this.path,
    );
  }

  @override
  String toString() {
    return 'MediaElement(id: $id, fileName: $fileName, type: $type, relatedTo: $relatedTo, path: $path)';
  }

  @override
  bool operator ==(covariant MediaElement other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.fileName == fileName &&
      other.type == type &&
      other.relatedTo == relatedTo &&
      other.path == path;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      fileName.hashCode ^
      type.hashCode ^
      relatedTo.hashCode ^
      path.hashCode;
  }
}
