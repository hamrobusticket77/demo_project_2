import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'answer_question_model.g.dart';

@HiveType(typeId: 31)
class AnswerQuestionModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  dynamic deletedAt;
  @HiveField(2)
  String callerFirstName;
  @HiveField(3)
  String callerLastName;
  @HiveField(4)
  dynamic callerMiddleName;
  @HiveField(5)
  String callerPhoneNumber;
  @HiveField(6)
  String callerEmail;
  @HiveField(7)
  List<QuestionAndAnswer> questionAndAnswer;
  @HiveField(8)
  String address;
  @HiveField(9)
  FarmerDetails farmerDetails;
  String? createdAt;
  AnswerQuestionModel({
    required this.id,
    required this.deletedAt,
    required this.callerFirstName,
    required this.callerLastName,
    required this.callerMiddleName,
    required this.callerPhoneNumber,
    required this.callerEmail,
    required this.questionAndAnswer,
    required this.address,
    required this.farmerDetails,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'deletedAt': deletedAt,
      'callerFirstName': callerFirstName,
      'callerLastName': callerLastName,
      'callerMiddleName': callerMiddleName,
      'callerPhoneNumber': callerPhoneNumber,
      'callerEmail': callerEmail,
      'questionAndAnswer': questionAndAnswer.map((x) => x.toMap()).toList(),
      'address': address,
      'farmerDetails': farmerDetails.toMap(),
      'createdAt': createdAt,
    };
  }

  factory AnswerQuestionModel.fromMap(Map<String, dynamic> map) {
    return AnswerQuestionModel(
      id: map['id'] ?? {},
      deletedAt: map['deletedAt'] as dynamic,
      callerFirstName: map['callerFirstName'] ?? '',
      callerLastName: map['callerLastName'] ?? '',
      callerMiddleName: map['callerMiddleName'] ?? '',
      callerPhoneNumber: map['callerPhoneNumber'] ?? '',
      callerEmail: map['callerEmail'] ?? '',
      // questionAndAnswer: List<QuestionAndAnswer>.from(
      //   (map['questionAndAnswer'] as List<int>).map<QuestionAndAnswer>(
      //     (x) => QuestionAndAnswer.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
      questionAndAnswer: List.from(map['questionAndAnswer'] ?? [])
          .map((e) => QuestionAndAnswer.fromMap(e))
          .toList(),

      address: map['address'] ?? '',
      farmerDetails:
          FarmerDetails.fromMap(map['farmerDetails'] as Map<String, dynamic>),

      createdAt: map['createdAt'] ?? "",
    );
  }

  AnswerQuestionModel copyWith({
    String? id,
    dynamic deletedAt,
    String? callerFirstName,
    String? callerLastName,
    dynamic callerMiddleName,
    String? callerPhoneNumber,
    String? callerEmail,
    List<QuestionAndAnswer>? questionAndAnswer,
    String? address,
    FarmerDetails? farmerDetails,
    String? createdAt,
  }) {
    return AnswerQuestionModel(
      id: id ?? this.id,
      deletedAt: deletedAt ?? this.deletedAt,
      callerFirstName: callerFirstName ?? this.callerFirstName,
      callerLastName: callerLastName ?? this.callerLastName,
      callerMiddleName: callerMiddleName ?? this.callerMiddleName,
      callerPhoneNumber: callerPhoneNumber ?? this.callerPhoneNumber,
      callerEmail: callerEmail ?? this.callerEmail,
      questionAndAnswer: questionAndAnswer ?? this.questionAndAnswer,
      address: address ?? this.address,
      farmerDetails: farmerDetails ?? this.farmerDetails,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'AnswerQuestionModel(id: $id,  deletedAt: $deletedAt, callerFirstName: $callerFirstName, callerLastName: $callerLastName, callerMiddleName: $callerMiddleName, callerPhoneNumber: $callerPhoneNumber, callerEmail: $callerEmail, questionAndAnswer: $questionAndAnswer, address: $address, farmerDetails: $farmerDetails)';
  }

  @override
  bool operator ==(covariant AnswerQuestionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.deletedAt == deletedAt &&
        other.callerFirstName == callerFirstName &&
        other.callerLastName == callerLastName &&
        other.callerMiddleName == callerMiddleName &&
        other.callerPhoneNumber == callerPhoneNumber &&
        other.callerEmail == callerEmail &&
        listEquals(other.questionAndAnswer, questionAndAnswer) &&
        other.address == address &&
        other.farmerDetails == farmerDetails;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        deletedAt.hashCode ^
        callerFirstName.hashCode ^
        callerLastName.hashCode ^
        callerMiddleName.hashCode ^
        callerPhoneNumber.hashCode ^
        callerEmail.hashCode ^
        questionAndAnswer.hashCode ^
        address.hashCode ^
        farmerDetails.hashCode;
  }
}

@HiveType(typeId: 32)
class FarmerDetails {
  @HiveField(0)
  String id;
  @HiveField(1)
  String addedBy;
  @HiveField(2)
  dynamic userId;
  FarmerDetails({
    required this.id,
    required this.addedBy,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'addedBy': addedBy,
      'userId': userId,
    };
  }

  factory FarmerDetails.fromMap(Map<String, dynamic> map) {
    return FarmerDetails(
      id: map['id'] as String,
      addedBy: map['addedBy'] ?? '',
      userId: map['userId'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory FarmerDetails.fromJson(String source) =>
      FarmerDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  FarmerDetails copyWith({
    String? id,
    String? addedBy,
    dynamic userId,
  }) {
    return FarmerDetails(
      id: id ?? this.id,
      addedBy: addedBy ?? this.addedBy,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() =>
      'FarmerDetails(id: $id, addedBy: $addedBy, userId: $userId)';

  @override
  bool operator ==(covariant FarmerDetails other) {
    if (identical(this, other)) return true;

    return other.id == id && other.addedBy == addedBy && other.userId == userId;
  }

  @override
  int get hashCode => id.hashCode ^ addedBy.hashCode ^ userId.hashCode;
}

@HiveType(typeId: 33)
class QuestionAndAnswer {
  @HiveField(0)
  String id;
  @HiveField(1)
  String createdAt;
  @HiveField(2)
  String deletedAt;
  @HiveField(3)
  String question;
  @HiveField(4)
  String answer;
  QuestionAndAnswer({
    required this.id,
    required this.createdAt,
    required this.deletedAt,
    required this.question,
    required this.answer,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'deletedAt': deletedAt,
      'question': question,
      'answer': answer,
    };
  }

  factory QuestionAndAnswer.fromMap(Map<String, dynamic> map) {
    return QuestionAndAnswer(
      id: map['id'] ?? '',
      createdAt: map['createdAt'] ?? '',
      deletedAt: map['deletedAt'] ?? '',
      question: map['question'] ?? '',
      answer: map['answer'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionAndAnswer.fromJson(String source) =>
      QuestionAndAnswer.fromMap(json.decode(source) as Map<String, dynamic>);

  QuestionAndAnswer copyWith({
    String? id,
    String? createdAt,
    String? deletedAt,
    String? question,
    String? answer,
  }) {
    return QuestionAndAnswer(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }

  @override
  String toString() {
    return 'QuestionAndAnswer(id: $id, createdAt: $createdAt, deletedAt: $deletedAt, question: $question, answer: $answer)';
  }

  @override
  bool operator ==(covariant QuestionAndAnswer other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.deletedAt == deletedAt &&
        other.question == question &&
        other.answer == answer;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        deletedAt.hashCode ^
        question.hashCode ^
        answer.hashCode;
  }
}
