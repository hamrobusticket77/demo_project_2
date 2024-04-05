import 'package:timeago/timeago.dart' as timeago;

class QuestionModel {
  final String id;
  final String createdAt;
  final String question;

  final String time;
  QuestionModel(
      {required this.id,
      required this.createdAt,
      required this.question,
      required this.time});

  QuestionModel copyWith({
    String? id,
    String? createdAt,
    String? question,
    String? time,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      question: question ?? this.question,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'question': question,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
        id: map['id'] ?? '',
        createdAt: map['createdAt'] ?? '',
        question: map['question'] ?? '',
        time: timeago
            .format(DateTime.tryParse(map["createdAt"]) ?? DateTime.now()));
  }

  @override
  String toString() =>
      'QuestionModel(id: $id, createdAt: $createdAt, question: $question)';

  @override
  bool operator ==(covariant QuestionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.question == question;
  }

  @override
  int get hashCode => id.hashCode ^ createdAt.hashCode ^ question.hashCode;
}
