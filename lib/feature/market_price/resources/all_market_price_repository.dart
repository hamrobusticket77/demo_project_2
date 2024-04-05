import 'package:krishi_hub/feature/market_price/model/market_price_model.dart';

class AllMarketPriceRepository {
  final Map<String, MarketPriceModel> _getMarketPrice = {};
  Map<String, MarketPriceModel> get getMarketPrice => _getMarketPrice;

  addAll(Map<String, MarketPriceModel> other) {
    _getMarketPrice.addAll(other);
  }
}
