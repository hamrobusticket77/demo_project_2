import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/market_price/cubit/market_price_cubit.dart';
import 'package:krishi_hub/feature/market_price/resources/market_price_repository.dart';
import 'package:krishi_hub/feature/market_price/ui/widget/market_widget.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MarketPriceCubit(
          marketPriceRepository:
              RepositoryProvider.of<MarketPriceRepository>(context))
        ..getMarketPrice(),
      child: const MarketWidget(),
    );
  }
}
