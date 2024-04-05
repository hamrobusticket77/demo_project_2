import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/demand/cubit/seed_demand_cubit.dart';
import 'package:krishi_hub/feature/demand/model/demand_model.dart';
import 'package:krishi_hub/feature/demand/resource/demand_repository.dart';
import 'package:krishi_hub/feature/demand/ui/widget/demand_widget.dart';

class DemandPage extends StatelessWidget {
  final DemandModel? demand;
  const DemandPage({
    super.key,
    this.demand,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SeedDemandCubit>(
      create: (context) => SeedDemandCubit(
          demandRepository: RepositoryProvider.of<DemandRepository>(context)),
      child: DemandWidget(demand: demand),
    );
  }
}
