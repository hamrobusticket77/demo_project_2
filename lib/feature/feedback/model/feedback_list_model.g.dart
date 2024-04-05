// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedbackListModelImpl _$$FeedbackListModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FeedbackListModelImpl(
      id: json['id'] as String,
      createdAt: json['createdAt'] as String?,
      deletedAt: json['deletedAt'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      createdBy: json['createdBy'] as String?,
    );

Map<String, dynamic> _$$FeedbackListModelImplToJson(
        _$FeedbackListModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'deletedAt': instance.deletedAt,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'title': instance.title,
      'description': instance.description,
      'createdBy': instance.createdBy,
    };
