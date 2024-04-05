import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/faq/cubit/get_faq_cubit.dart';

import '../widget/faq_widget.dart';

class FaqListPage extends StatelessWidget {
  const FaqListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FAQCubit(faqRepository: RepositoryProvider.of(context))..getFaq(),
      child: const FAQListWidget(),
    );
  }
}
