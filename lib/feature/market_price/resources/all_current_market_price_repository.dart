import 'package:krishi_hub/feature/market_price/model/current_market_price_model.dart';

class AllCurrentMarketPriceRepository {
  final Map<String, CurrentMarketPriceModel> _getCurrentMarketPrice = {};
  Map<String, CurrentMarketPriceModel> get getCurrentMarketPrice =>
      _getCurrentMarketPrice;

  addAll(Map<String, CurrentMarketPriceModel> other) {
    _getCurrentMarketPrice.addAll(other);
  }
}
