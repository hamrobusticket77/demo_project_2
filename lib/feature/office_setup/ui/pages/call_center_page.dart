import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/office_setup/cubit/get_anserquestion_cubit.dart';
import 'package:krishi_hub/feature/office_setup/resources/call_center_repository.dart';
import 'package:krishi_hub/feature/office_setup/ui/widget/answer_question_widget.dart';

class CallcenterPage extends StatelessWidget {
  const CallcenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GetAnswerQuestionCubit(
          callcenterRepository:
              RepositoryProvider.of<CallCenterRepository>(context))
        ..getAnswerQuestion(),
      child: const AnswerQuestionWidget(),
    );
  }
}
