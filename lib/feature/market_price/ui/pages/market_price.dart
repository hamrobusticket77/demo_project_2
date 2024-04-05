import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/market_price/cubit/get_market_price_cubit.dart';
import 'package:krishi_hub/feature/market_price/ui/widget/market_price_widget.dart';

class MarketPrice extends StatelessWidget {
  const MarketPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetMarketPriceCubit(
        marketPriceRepository: RepositoryProvider.of(context),
      )..getMarketPrice(),
      child: const MarketPriceWidget(),
    );
  }
}
