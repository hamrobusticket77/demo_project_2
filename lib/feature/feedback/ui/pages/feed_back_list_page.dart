import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/feedback/cubit/get_feedback_cubit.dart';
import 'package:krishi_hub/feature/feedback/resource/feedback_repository.dart';
import 'package:krishi_hub/feature/feedback/ui/widget/feedback_list_widget.dart';

class FeedbackListPage extends StatelessWidget {
  const FeedbackListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetFeedbackCubit(
          feedbackRepository:
              RepositoryProvider.of<FeedbackRepository>(context))
        ..getFeedback(),
      child: const FeedbackListWidget(),
    );
  }
}
