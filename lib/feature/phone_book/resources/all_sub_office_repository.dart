import 'package:krishi_hub/feature/phone_book/model/sub_office_model.dart';

class AllSubOfficeRepository {
  final Map<String, SubofficeModel> _getSubOffice = {};
  Map<String, SubofficeModel> get getSuboffice => _getSubOffice;

  addAll(Map<String, SubofficeModel> other) {
    _getSubOffice.addAll(other);
  }

  removeAll() {
    _getSubOffice.clear();
  }
}
