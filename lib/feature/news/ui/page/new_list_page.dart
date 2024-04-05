import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/get_news_cubit.dart';
import '../widget/news_list_widget.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetNewsCubit(newsRepository: RepositoryProvider.of(context))
            ..getNews(),
      child: const NewsListWiget(),
    );
  }
}
