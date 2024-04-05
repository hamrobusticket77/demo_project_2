import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/krishi_knowledge/cubit/disease_report_cubit.dart';
import 'package:krishi_hub/feature/krishi_knowledge/resources/krishi_repository.dart';
import 'package:krishi_hub/feature/krishi_knowledge/ui/widgets/disease_report_form_widget.dart';

class DiseaseReportPage extends StatelessWidget {
  const DiseaseReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiseaseReportCubit(
          krishiRepository: RepositoryProvider.of<KrishiRepository>(context)),
      child: const DiseaseReportWidget(),
    );
  }
}
