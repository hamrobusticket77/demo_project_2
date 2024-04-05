import 'package:krishi_hub/feature/feedback/model/feedback_list_model.dart';

class AllFeedbackRepository {
  final Map<String, FeedbackListModel> _feedbacklist = {};
  Map<String, FeedbackListModel> get getFeedback => _feedbacklist;

  addAll(Map<String, FeedbackListModel> other) {
    _feedbacklist.addAll(other);
  }
}
