import 'dart:convert';

import 'package:krishi_hub/feature/market_price/model/market_model.dart';
import 'package:krishi_hub/feature/market_price/model/product_model.dart';

class MarketPriceModel {
  final String id;
  final String createdAt;
  final String date;
  final MarketModel market;
  final ProductModel product;
  MarketPriceModel({
    required this.id,
    required this.createdAt,
    required this.market,
    required this.date,
    required this.product,
  });

  MarketPriceModel copyWith({
    String? id,
    String? createdAt,
    ProductModel? product,
    MarketModel? market,
    String? date,
  }) {
    return MarketPriceModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      product: product ?? this.product,
      market: market ?? this.market,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'market': market.toMap(),
      'product': product.toMap(),
      'date': date,
    };
  }

  factory MarketPriceModel.fromMap(Map<String, dynamic> map) {
    return MarketPriceModel(
      id: map['id'] ?? "",
      createdAt: map['createdAt'] ?? "",
      date: map['date'] ?? "",
      market: MarketModel.fromMap(map['market'] ?? {}),
      product: ProductModel.fromMap(map['product'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory MarketPriceModel.fromJson(String source) =>
      MarketPriceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MarketPriceModel(id: $id, createdAt: $createdAt, market: $market, product: $product, date: $date)';
  }

  @override
  bool operator ==(covariant MarketPriceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.market == market &&
        other.date == date &&
        other.product == product;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        market.hashCode ^
        date.hashCode ^
        product.hashCode;
  }
}
