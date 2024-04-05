import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/expertise/cubit/get_expertise_cubit.dart';
import 'package:krishi_hub/feature/expertise/ui/widget/expertise_widget.dart';

class ExpertisePage extends StatelessWidget {
  const ExpertisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExpertiseCubit(expertiseRepository: RepositoryProvider.of(context))
            ..getExpertise(),
      child: const ExpertiseWidget(),
    );
  }
}
