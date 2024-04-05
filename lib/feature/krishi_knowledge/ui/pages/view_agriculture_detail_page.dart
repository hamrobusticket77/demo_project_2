import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/krishi_knowledge/constant/agriculture_knowledge_type.dart';
import 'package:krishi_hub/feature/krishi_knowledge/cubit/get_agricultureDetail_cubit.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_knowledge_model.dart';
import 'package:krishi_hub/feature/krishi_knowledge/ui/widgets/agriculture_detail_widget.dart';

class AgricultureDetailPage extends StatelessWidget {
  final KnowledgetTypeModel data;

  final AgricultureKnowledgeModel agricultureKnowledgeModel;

  const AgricultureDetailPage(
      {super.key, required this.agricultureKnowledgeModel, required this.data});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetAgricultureDetailCubit(
          krishiRepository: RepositoryProvider.of(context))
        ..getAgricultureDetail(
          id: agricultureKnowledgeModel.id,
          type: data.type,
        ),
      child: const AgricultureDetailWidget(),
    );
  }
}
