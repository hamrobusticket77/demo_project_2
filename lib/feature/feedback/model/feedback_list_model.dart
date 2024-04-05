import 'package:freezed_annotation/freezed_annotation.dart';
part 'feedback_list_model.freezed.dart';
part 'feedback_list_model.g.dart';

@freezed
class FeedbackListModel with _$FeedbackListModel {
  const factory FeedbackListModel({
    required String id,
    required String? createdAt,
    required String? deletedAt,
    required String? name,
    required String? phoneNumber,
    required String? email,
    required String? title,
    required String? description,
    required String? createdBy,
  }) = _FeedbackListModel;

  factory FeedbackListModel.fromJson(Map<String, dynamic> json) =>
      _$FeedbackListModelFromJson(json);
}
