import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/crop_care/cubit/get_seed_store_cubit.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/seed_store_widget.dart';

class SeedStorePage extends StatelessWidget {
  const SeedStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetSeedStoreCubit(
        cropCareRepository: RepositoryProvider.of(context),
      )..getSeedStore(),
      child: const SeedStoreWidget(),
    );
  }
}
