import 'package:krishi_hub/feature/chat/model/question_model.dart';

class AllQuestionRepository {
  final Map<String, QuestionModel> _questions = {};
  Map<String, QuestionModel> get getQuestions => _questions;

  addAll(Map<String, QuestionModel> other) {
    _questions.addAll(other);
  }

  add(QuestionModel other) {
    _questions[other.id] = other;
  }

  removeAll() {
    _questions.clear();
  }
}
