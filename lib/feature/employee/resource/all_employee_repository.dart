import 'package:krishi_hub/feature/employee/model/employee_model.dart';

class AllEmployeeRepository {
  final Map<String, EmployeeModel> _getemployee = {};
  Map<String, EmployeeModel> get getemployeelist => _getemployee;

  addAll(Map<String, EmployeeModel> other) {
    _getemployee.addAll(other);
  }

  removeAll() {
    _getemployee.clear();
  }
}
