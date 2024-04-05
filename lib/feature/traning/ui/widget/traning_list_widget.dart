import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/search_utils.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/common/widget/text_field/custom_search_field.dart';
import 'package:krishi_hub/feature/traning/cubit/get_training_cubit.dart';
import 'package:krishi_hub/feature/traning/resources/all_training_repository.dart';
import 'package:krishi_hub/feature/traning/ui/pages/training_details_page.dart';
import 'package:krishi_hub/feature/traning/ui/widget/traning_card.dart';

class TraningListWidget extends StatefulWidget {
  const TraningListWidget({super.key});

  @override
  State<TraningListWidget> createState() => _TraningListWidgetState();
}

class _TraningListWidgetState extends State<TraningListWidget> {
  final TextEditingController _searchController = TextEditingController();

  bool _isLoadMoreActive = false;
  final ScrollController _scrollController = ScrollController();

  _search(String searchSlug) {
    SearchUtils().search(() {
      context
          .read<GetTrainingCubit>()
          .getTrainingList(searchSlug: searchSlug.trim());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allTraining =
        RepositoryProvider.of<AllTraningRepositiry>(context).getTraningList;
    return BlocListener<GetTrainingCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonDataFetchSuccess) {
            setState(() {
              _isLoadMoreActive = false;
            });
          }
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: LocaleKeys.traininglist.tr(),
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification.metrics.pixels >
                  scrollNotification.metrics.maxScrollExtent / 2) {
                if (!_isLoadMoreActive &&
                    _scrollController.position.userScrollDirection ==
                        ScrollDirection.reverse) {
                  _isLoadMoreActive = true;
                  context
                      .read<GetTrainingCubit>()
                      .loadMoreTraining(searchSlug: _searchController.text);
                }
              }
              return true;
            },
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: CustomTheme.symmetricHozPadding.wp,
                    right: CustomTheme.symmetricHozPadding.wp,
                    top: 15.hp,
                  ),
                  child: CustomSearchField(
                    controller: _searchController,
                    hintText: LocaleKeys.search.tr(),
                    onChanged: (value) {
                      _search(value);
                    },
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                      _search(value);
                    },
                    onTapSuffixButton: () {
                      _searchController.clear();
                      _search("");
                    },
                  ),
                ),
                SizedBox(height: 10.hp),
                Expanded(
                  child: BlocBuilder<GetTrainingCubit, CommonState>(
                    buildWhen: (context, state) {
                      if (state is CommonDummyLoading) {
                        return false;
                      }
                      return true;
                    },
                    builder: (context, state) {
                      if (state is CommonLoading) {
                        return GridViewPlaceHolder(
                          itemHeight: 170.hp,
                        );
                      } else if (state is CommonError) {
                        return CommonErrorWidget(
                          message: state.message,
                        );
                      } else if (state is CommonNoData) {
                        return const Center(child: CommonNoDataWidget());
                      } else if (state is CommonDataFetchSuccess<String>) {
                        return SingleChildScrollView(
                          controller: _scrollController,
                          child: GridView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.symmetric(
                                vertical: 5.hp, horizontal: 8),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 8.hp,
                            ),
                            children: List.generate(state.data.length, (index) {
                              final data = allTraining[state.data[index]];
                              if (data != null) {
                                return TraningCard(
                                  traningModel: data,
                                  onPressed: () {
                                    NavigationService.push(
                                        target: TrainingDetailsPage(
                                      id: data.id,
                                    )).then((value) {
                                      if (value != null && value) {
                                        context
                                            .read<GetTrainingCubit>()
                                            .getTrainingList();
                                      }
                                    });
                                  },
                                );
                              } else {
                                return const SizedBox();
                              }
                            }),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                )
              ],
            ),
          ),
        ));
  }
}
