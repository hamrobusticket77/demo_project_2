// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MissionModel {
  final String id;
    final String visionAndMission;
  MissionModel({
    required this.id,
    required this.visionAndMission,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'visionAndMission': visionAndMission,
    };
  }

  factory MissionModel.fromMap(Map<String, dynamic> map) {
    return MissionModel(
      id: map['id'] as String,
      visionAndMission: map['visionAndMission'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MissionModel.fromJson(String source) => MissionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  MissionModel copyWith({
    String? id,
    String? visionAndMission,
  }) {
    return MissionModel(
      id: id ?? this.id,
      visionAndMission: visionAndMission ?? this.visionAndMission,
    );
  }

  @override
  String toString() => 'MissionModel(id: $id, visionAndMission: $visionAndMission)';

  @override
  bool operator ==(covariant MissionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.visionAndMission == visionAndMission;
  }

  @override
  int get hashCode => id.hashCode ^ visionAndMission.hashCode;
}
