import 'package:krishi_hub/feature/crop_care/model/doctor_record_model.dart';

class AllExpertiseRepository {
  final Map<String, DoctorRecordModel> _getExpertise = {};
  Map<String, DoctorRecordModel> get getExpertise => _getExpertise;

  addAll(Map<String, DoctorRecordModel> other) {
    _getExpertise.addAll(other);
  }

  removeAll() {
    _getExpertise.clear();
  }
}
