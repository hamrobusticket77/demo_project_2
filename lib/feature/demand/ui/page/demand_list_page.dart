import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/demand/cubit/get_demand_list_cubit.dart';
import 'package:krishi_hub/feature/demand/resource/demand_repository.dart';
import 'package:krishi_hub/feature/demand/ui/widget/demand_list_widget.dart';

class DemandListPage extends StatelessWidget {
  const DemandListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetDemandListCubit(
          demandlistRepository:
              RepositoryProvider.of<DemandRepository>(context))
        ..getDemandList(),
      child: const DemandListWidget(),
    );
    // return DemandWidget();
  }
}
