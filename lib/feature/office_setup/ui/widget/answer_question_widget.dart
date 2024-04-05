import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/office_setup/cubit/get_anserquestion_cubit.dart';
import 'package:krishi_hub/feature/office_setup/resources/all_answer_question.dart';
import 'package:krishi_hub/feature/office_setup/ui/widget/answer_question_card.dart';
import 'package:krishi_hub/feature/office_setup/ui/widget/answer_question_detail.dart';

class AnswerQuestionWidget extends StatefulWidget {
  const AnswerQuestionWidget({super.key});

  @override
  State<AnswerQuestionWidget> createState() => _EmployeeWidgetState();
}

class _EmployeeWidgetState extends State<AnswerQuestionWidget> {
  @override
  @override
  Widget build(BuildContext context) {
    final allanswerquestion =
        RepositoryProvider.of<AllAnswerQuestionRepository>(context)
            .getAnswerQuestionList;
    return BlocListener<GetAnswerQuestionCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonDataFetchSuccess) {
          // setState(() {
          //   _isLoadMoreActive = false;
          // }
          // );
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.callcenter.tr(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<GetAnswerQuestionCubit, CommonState>(
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
                            scrollNotification.metrics.maxScrollExtent / 2) {}
                        return true;
                      },
                      child: Column(
                        children: state.data.map((dataId) {
                          final data = allanswerquestion[dataId];

                          if (data != null) {
                            return SizedBox(
                              child: AnswerQuestionCard(
                                onPressed: () {
                                  NavigationService.push(
                                      target: AnswerQuestionDetail(
                                    answerQuestionModel: data,
                                  ));
                                },
                                answerquestionModel: data,
                              ),
                            );
                          }
                          return const SizedBox();
                        }).toList(),
                      ),
                    );
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
