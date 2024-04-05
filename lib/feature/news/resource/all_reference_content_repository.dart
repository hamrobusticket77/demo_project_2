import 'package:krishi_hub/feature/refrence_contant/model/reference_content_model.dart';

class AllReferenceContentRepository {
  final Map<String, ReferenceContentModel> _referencecontent = {};
  Map<String, ReferenceContentModel> get getReferenceContent =>
      _referencecontent;

  addAll(Map<String, ReferenceContentModel> other) {
    _referencecontent.addAll(other);
  }

  removeAll() {
    _referencecontent.clear();
  }
}
