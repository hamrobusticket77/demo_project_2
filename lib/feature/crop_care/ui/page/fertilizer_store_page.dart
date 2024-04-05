import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/crop_care/cubit/get_fertilizer_store_cubit.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/fertilizer_store_widget.dart';

class FertilizerStorePage extends StatelessWidget {
  const FertilizerStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetFertilizerStoreCubit(
        cropCareRepository: RepositoryProvider.of(context),
      )..getFertilizerStore(),
      child: const FertilizerStoreWidget(),
    );
  }
}
