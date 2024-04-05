import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/news/resource/news_repository.dart';
import 'package:krishi_hub/feature/refrence_contant/cubit/reference_content_cubit.dart';
import 'package:krishi_hub/feature/refrence_contant/ui/widget/reference_content_widget.dart';

class ReferenceContentPage extends StatelessWidget {
  const ReferenceContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReferenceContentCubit(
          newsRepository: RepositoryProvider.of<NewsRepository>(context))
        ..getReferenceContent(),
      child:const  ReferenceContentWidget(),
    );
  }
}
