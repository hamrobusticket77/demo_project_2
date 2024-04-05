import 'package:krishi_hub/feature/phone_book/model/office_model.dart';

class AllOfficeRepository {
  final Map<String, OfficeModel> _getoffice = {};
  Map<String, OfficeModel> get getOffice => _getoffice;

  addAll(Map<String, OfficeModel> other) {
    _getoffice.addAll(other);
  }

  removeAll() {
    _getoffice.clear();
  }
}
