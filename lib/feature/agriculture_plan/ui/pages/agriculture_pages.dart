import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/agriculture_plan/cubit/get_agriculture_plan_cubit.dart';
import 'package:krishi_hub/feature/agriculture_plan/resources/agriculture_repository.dart';
import 'package:krishi_hub/feature/agriculture_plan/ui/widget/agriculuteplan_list.dart';

class AgriculturePlanPage extends StatelessWidget {
  const AgriculturePlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GetAgricultureCubit(
          agricultureRepository:
              RepositoryProvider.of<AgricultureRepository>(context))
        ..getAgriculturePlan(),
      child: const AgricultureplanListWidget(),
    );
  }
}
