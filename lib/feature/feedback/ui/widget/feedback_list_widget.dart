import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/feature/feedback/cubit/get_feedback_cubit.dart';
import 'package:krishi_hub/feature/feedback/resource/all_feedback_repository.dart';
import 'package:krishi_hub/feature/feedback/ui/widget/feedback_card.dart';
import 'package:krishi_hub/feature/feedback/ui/widget/feedback_detail.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';

class FeedbackListWidget extends StatefulWidget {
  const FeedbackListWidget({super.key});

  @override
  State<FeedbackListWidget> createState() => _FeedbackListWidgetState();
}

class _FeedbackListWidgetState extends State<FeedbackListWidget> {
  bool _isLoadMoreActive = false;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final allNews =
        RepositoryProvider.of<AllFeedbackRepository>(context).getFeedback;
    return BlocListener<GetFeedbackCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonDataFetchSuccess) {
            setState(() {
              _isLoadMoreActive = false;
            });
          }
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: LocaleKeys.feedback.tr(),
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification.metrics.pixels >
                  scrollNotification.metrics.maxScrollExtent / 2) {
                if (!_isLoadMoreActive &&
                    _scrollController.position.userScrollDirection ==
                        ScrollDirection.reverse) {
                  _isLoadMoreActive = true;
                  context.read<GetFeedbackCubit>().loadMoreFeedback();
                }
              }
              return true;
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  BlocBuilder<GetFeedbackCubit, CommonState>(
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
                        return Column(
                            children: List.generate(state.data.length, (index) {
                          final data = allNews[state.data[index]];

                          if (data != null) {
                            return SizedBox(
                              //  height: 140.hp,
                              child: FeedbackCard(
                                onPressed: () {
                                  NavigationService.push(
                                      target: FeedbackDetailsWidget(
                                    feedbackModel: data,
                                  ));
                                },
                                feedbacklistModel: data,
                              ),
                            );
                          }
                          return const SizedBox();
                        }));
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
        ));
  }
}
