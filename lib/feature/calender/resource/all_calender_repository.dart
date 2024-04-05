import 'package:krishi_hub/feature/calender/model/calender_model.dart';

class AllCalenderRepository {
  final Map<String, CalenderModel> _calender = {};
  Map<String, CalenderModel> get getCalender => _calender;

  addAll(Map<String, CalenderModel> other) {
    _calender.addAll(other);
  }

  clearAll() {
    _calender.clear();
  }
}
