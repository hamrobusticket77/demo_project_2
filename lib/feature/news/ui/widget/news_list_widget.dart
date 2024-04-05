import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import '../../../../common/common_error_widget.dart';
import '../../../../common/common_nodata_widget.dart';
import '../../../../common/constant/locale_keys.dart';
import '../../../../common/cubit/data_state.dart';
import '../../../../common/navigation/navigation_service.dart';
import '../../../../common/widget/app_bar/custom_app_bar.dart';
import '../../../../common/widget/shimmer/shimmer_widget.dart';
import '../../cubit/get_news_cubit.dart';
import '../../resource/all_news_repository.dart';
import 'news_card.dart';
import 'news_details_widget.dart';

class NewsListWiget extends StatefulWidget {
  const NewsListWiget({super.key});

  @override
  State<NewsListWiget> createState() => _NewsListWigetState();
}

class _NewsListWigetState extends State<NewsListWiget> {
  // @override
  // void initState() {

  //   context.read<GetNewsCubit>().getNews();
  //   super.initState();
  // }
  bool _isLoadMoreActive = false;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final allNews = RepositoryProvider.of<AllNewsRepository>(context).getNews;
    return BlocListener<GetNewsCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonDataFetchSuccess) {
          setState(() {
            _isLoadMoreActive = false;
          });
        }
      },
      child: Scaffold(
      
        appBar: CustomAppBar(
          title: LocaleKeys.newsAndEvent.tr(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<GetNewsCubit, CommonState>(
                buildWhen: (context, state) {
                  if (state is CommonDummyLoading) {
                    return false;
                  }
                  return true;
                },
                builder: (context, state) {
                  if (state is CommonLoading) {
                    return ListViewPlaceHolder(
                      itemHeight: 100.hp,
                    );
                  } else if (state is CommonError) {
                    return CommonErrorWidget(
                      message: state.message,
                    );
                  } else if (state is CommonNoData) {
                    return const Center(child: CommonNoDataWidget());
                  } else if (state is CommonDataFetchSuccess<String>) {
                    return NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (scrollNotification.metrics.pixels >
                              scrollNotification.metrics.maxScrollExtent / 2) {
                            if (!_isLoadMoreActive &&
                                _scrollController
                                        .position.userScrollDirection ==
                                    ScrollDirection.reverse) {
                              _isLoadMoreActive = true;
                              context.read<GetNewsCubit>().loadMoreNews();
                            }
                          }
                          return true;
                        },
                        child: Column(
                            children: List.generate(state.data.length, (index) {
                          final data = allNews[state.data[index]];

                          if (data != null) {
                            return SizedBox(
                              child: NewsCard(
                                onPressed: () {
                                  NavigationService.push(
                                      target: NewsDetailsWidget(
                                    newsModel: data,
                                  ));
                                },
                                newsModel: data,
                              ),
                            );
                          }
                          return const SizedBox();
                        })));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }
}
