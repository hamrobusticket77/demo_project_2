import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/market_price/cubit/get_current_marker_price_detail_cubit.dart';
import 'package:krishi_hub/feature/market_price/model/current_market_price_model.dart';
import 'package:krishi_hub/feature/market_price/ui/widget/current_market_detail_widget.dart';

class CurrentMarketDetailPage extends StatelessWidget {
  final CurrentMarketPriceModel currentMarketPriceModel;
  const CurrentMarketDetailPage(
      {super.key, required this.currentMarketPriceModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetCurrentMarketPriceDetailCubit(
          marketPriceRepository: RepositoryProvider.of(context))
        ..getCurrentMarketPriceDetailCubit(id: currentMarketPriceModel.id),
      child: const CurrentMarketDetail(),
    );
  }
}
