import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/krishi_knowledge/cubit/get_disease_report_cubit.dart';
import 'package:krishi_hub/feature/krishi_knowledge/ui/widgets/disease_report_view_widget.dart';

class DiseaseReportViewPage extends StatelessWidget {
  const DiseaseReportViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetDiseaseReportCubit(
          krishiRepository: RepositoryProvider.of(context))
        ..getDiseaseReport(),
      child: const DiseaseReportViewWidget(),
    );
  }
}
