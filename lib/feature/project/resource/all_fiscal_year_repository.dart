import 'package:krishi_hub/common/model/fiscal_year.dart';

class AllFiscalYearRepository {
  final Map<String, FiscalYear> _items = {};
  Map<String, FiscalYear> get getItems => _items;

  addAll(Map<String, FiscalYear> other) {
    _items.addAll(other);
  }
}
