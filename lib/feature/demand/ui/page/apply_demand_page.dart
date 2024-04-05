import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/demand/cubit/apply_demand_cubit.dart';
import 'package:krishi_hub/feature/demand/cubit/demand_cubit.dart';
import 'package:krishi_hub/feature/demand/resource/demand_repository.dart';
import 'package:krishi_hub/feature/demand/ui/widget/apply_demand_widget.dart';

class ApplyDemandPage extends StatelessWidget {
  final String id;

  const ApplyDemandPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DemandCubit>(
          create: (context) => DemandCubit(
              demandlistRepository:
                  RepositoryProvider.of<DemandRepository>(context))
            ..getDemandById(id),
        ),
        BlocProvider(
            create: (context) => ApplyDemandCubit(
                demandRepository:
                    RepositoryProvider.of<DemandRepository>(context))),
      ],
      child: const ApplyDemandWidget(),
    );
  }
}
