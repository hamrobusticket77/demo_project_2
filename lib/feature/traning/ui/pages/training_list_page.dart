import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/traning/cubit/get_training_cubit.dart';
import 'package:krishi_hub/feature/traning/ui/widget/traning_list_widget.dart';

class TrainingListPage extends StatelessWidget {
  const TrainingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetTrainingCubit(
        traningRepository: RepositoryProvider.of(context),
      )..getTrainingList(),
      child: const TraningListWidget(),
    );
  }
}
