import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/demand/cubit/get_applied_demand_cubit.dart';
import 'package:krishi_hub/feature/demand/resource/demand_repository.dart';
import 'package:krishi_hub/feature/demand/ui/widget/applied_demand_list_widget.dart';

class AppliedDemandListPage extends StatelessWidget {
  const AppliedDemandListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetAppliedDemandCubit(
          demandlistRepository:
              RepositoryProvider.of<DemandRepository>(context))
        ..getAppliedDemand(),
      child: const AppliedDemandListWidget(),
    );
    // return DemandWidget();
  }
}
