import 'package:krishi_hub/feature/office_setup/model/office_setup_model.dart';

class AllCallCenterRepositoy {
  final Map<String, OfficeSetupModel> _callcenter = {};
  Map<String, OfficeSetupModel> get getofficesetup => _callcenter;

  addAll(Map<String, OfficeSetupModel> other) {
    _callcenter.addAll(other);
  }
}
