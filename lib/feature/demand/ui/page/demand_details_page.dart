import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/demand/cubit/demand_cubit.dart';
import 'package:krishi_hub/feature/demand/resource/demand_repository.dart';
import 'package:krishi_hub/feature/demand/ui/widget/demand_detail_widget.dart';

class DemandDetailsPage extends StatelessWidget {
  final String id;
  const DemandDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DemandCubit>(
      create: (context) => DemandCubit(
          demandlistRepository:
              RepositoryProvider.of<DemandRepository>(context))
        ..getDemandById(id),
      child: const DemandDetailWidget(),
    );
  }
}
