import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_knowledge_model.dart';

class AllAgricultureKnowledgeRepository {
  final Map<String, AgricultureKnowledgeModel> _agricultureKnowledge = {};
  Map<String, AgricultureKnowledgeModel> get getAgricultureKNowledge =>
      _agricultureKnowledge;

  addAll(Map<String, AgricultureKnowledgeModel> other) {
    _agricultureKnowledge.addAll(other);
  }
}
