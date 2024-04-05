import 'package:krishi_hub/feature/crop_care/model/doctor_record_model.dart';

class AllDoctorRecordRepository {
  final Map<String, DoctorRecordModel> _getDoctorRecord = {};
  Map<String, DoctorRecordModel> get getDoctorList => _getDoctorRecord;

  addAll(Map<String, DoctorRecordModel> other) {
    _getDoctorRecord.addAll(other);
  }

  removeAll() {
    _getDoctorRecord.clear();
  }
}
