import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/traning/cubit/apply_traning_cubit.dart';
import 'package:krishi_hub/feature/traning/cubit/get_training_details_cubit.dart';
import 'package:krishi_hub/feature/traning/resources/traning_repository.dart';
import 'package:krishi_hub/feature/traning/ui/widget/training_detail_widget.dart';

class TrainingDetailsPage extends StatelessWidget {
  final String id;
  const TrainingDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => GetTrainingDetailsCubit(
            traningRepository:
                RepositoryProvider.of<TrainingRepository>(context))
          ..getTrainingDetails(id),
      ),
      BlocProvider(
        create: (context) => ApplyTrainingCubit(
            traningRepository:
                RepositoryProvider.of<TrainingRepository>(context)),
      )
    ], child: const TrainingDetailWidget());
  }
}
