import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/model/photos.dart';

part 'training_model.g.dart';

@HiveType(typeId: 14)
class TrainingModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String startDate;
  @HiveField(3)
  final String endDate;
  @HiveField(4)
  final String venue;
  @HiveField(5)
  final String trainer;
  @HiveField(6)
  final bool isApplied;
  @HiveField(7)
  final Photos? media;
  @HiveField(8)
  final List<dynamic> trainingApplicants;
  TrainingModel({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.venue,
    required this.trainer,
    required this.isApplied,
    this.media,
    required this.trainingApplicants,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'startDate': startDate,
      'endDate': endDate,
      'venue': venue,
      'trainer': trainer,
      'isApplied': isApplied,
      'media': media?.toMap(),
      'trainingApplicants': trainingApplicants,
    };
  }

  factory TrainingModel.fromMap(Map<String, dynamic> map) {
    return TrainingModel(
      id: map['id'] ?? "",
      title: map['title'] ?? "",
      startDate: map['startDate'] ?? "",
      endDate: map['endDate'] ?? "",
      venue: map['venue'] ?? "",
      trainer: map['trainer'] ?? "",
      isApplied: map['isApplied'] ?? false,
      media: (map['media'] != null) ? Photos.fromMap(map['media']) : null,
      trainingApplicants:
          List.from(map["trainingApplicants"] ?? []).map((e) => e).toList(),
    );
  }

  TrainingModel copyWith({
    String? id,
    String? title,
    String? startDate,
    String? endDate,
    String? venue,
    String? trainer,
    bool? isApplied,
    Photos? media,
    List<dynamic>? trainingApplicants,
  }) {
    return TrainingModel(
      id: id ?? this.id,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      venue: venue ?? this.venue,
      trainer: trainer ?? this.trainer,
      isApplied: isApplied ?? this.isApplied,
      media: media ?? this.media,
      trainingApplicants: trainingApplicants ?? this.trainingApplicants,
    );
  }

  @override
  bool operator ==(covariant TrainingModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.venue == venue &&
        other.trainer == trainer &&
        other.isApplied == isApplied &&
        other.trainingApplicants == trainingApplicants &&
        other.media == media;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        venue.hashCode ^
        trainer.hashCode ^
        isApplied.hashCode ^
        trainingApplicants.hashCode ^
        media.hashCode;
  }
}
