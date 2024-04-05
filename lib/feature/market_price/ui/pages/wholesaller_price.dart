import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/market_price/cubit/get_wholesaller_price_cubit.dart';
import 'package:krishi_hub/feature/market_price/ui/widget/wholesaler_market_price_widget.dart';

class WholeSallerPrice extends StatelessWidget {
  const WholeSallerPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWholeSallerPriceCubit(
          marketPriceRepository: RepositoryProvider.of(context))
        ..getWholeSallerPrice(),
      child: const WholeSalerPriceWidget(),
    );
  }
}
