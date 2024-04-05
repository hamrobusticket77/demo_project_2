import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/feature/news/cubit/get_news_cubit.dart';
import 'package:krishi_hub/feature/news/resource/all_news_repository.dart';
import 'package:krishi_hub/feature/news/ui/widget/news_details_widget.dart';

import '../../../../common/app/theme.dart';
import '../../../../common/common_error_widget.dart';
import '../../../../common/constant/locale_keys.dart';
import '../../../../common/cubit/data_state.dart';
import '../../../../common/widget/shimmer/shimmer_widget.dart';
import 'news_Cards.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final allNews = RepositoryProvider.of<AllNewsRepository>(context).getNews;

    return SliverToBoxAdapter(
      child: BlocBuilder<GetNewsCubit, CommonState>(
        buildWhen: (context, state) {
          if (state is CommonDummyLoading) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          if (state is CommonLoading) {
            return SizedBox(
              child: ListViewPlaceHolder(
                itemHeight: 100.hp,
                numberofItem: 1,
              ),
            );
          } else if (state is CommonError) {
            return CommonErrorWidget(
              hideImage: true,
              message: state.message,
            );
          } else if (state is CommonNoData) {
            return Center(child: Text((LocaleKeys.noDataFound.tr())));
          } else if (state is CommonDataFetchSuccess<String>) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: CustomTheme.symmetricHozPadding.wp,
                        vertical: 5),
                    child: Row(
                      children: List.generate(state.data.length, (index) {
                        final data = allNews[state.data[index]];
                        if (data != null) {
                          return SizedBox(
                            width: 320.wp,
                            // height: 125.hp,
                            child: NewsCards(
                              margin: EdgeInsets.only(right: 15.wp),
                              onPressed: () {
                                NavigationService.push(
                                    target: NewsDetailsWidget(
                                  newsModel: data,
                                ));
                              },
                              date: data.createdAt.toString(),
                              title: data.title,
                              imageUrl: (data.media.medias.isNotEmpty)
                                  ? data.media.medias.first.path
                                  : "",
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
