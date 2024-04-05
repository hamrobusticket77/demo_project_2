import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/krishi_knowledge/constant/agriculture_knowledge_type.dart';

import 'package:krishi_hub/feature/krishi_knowledge/cubit/get_agriculture_knowledge_cubit.dart';
import 'package:krishi_hub/feature/krishi_knowledge/ui/widgets/common_agriculture_knowledge_Widget.dart';

class CommonAgricultureKnowledge extends StatelessWidget {
  final KnowledgetTypeModel data;

  const CommonAgricultureKnowledge({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetAgricultureKnowledgeCubit(
          krishiRepository: RepositoryProvider.of(context))
        ..getAgricultureKnowledge(type: data.type),
      child: CommomAgricultureTypeKnowledgeWidget(
        data: data,
      ),
    );
  }
}
