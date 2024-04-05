import 'package:krishi_hub/feature/office_setup/model/answer_question_model.dart';

class AllAnswerQuestionRepository {
  final Map<String, AnswerQuestionModel> _answerquestionlist = {};
  Map<String, AnswerQuestionModel> get getAnswerQuestionList =>
      _answerquestionlist;

  addAll(Map<String, AnswerQuestionModel> other) {
    _answerquestionlist.addAll(other);
  }

  removeAll() {
    _answerquestionlist.clear();
  }
}
