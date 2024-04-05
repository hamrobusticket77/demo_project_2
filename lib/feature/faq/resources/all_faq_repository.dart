
import '../model/faq_model.dart';

class AllFaqRepository {
  final Map<String, FAQModel> _faq = {};
  Map<String, FAQModel> get getFaq => _faq;

  addAll(Map<String, FAQModel> other) {
    _faq.addAll(other);
  }

}
