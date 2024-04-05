import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';

import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/common_expandable_list_widget.dart';

import 'package:krishi_hub/feature/office_setup/model/answer_question_model.dart';

class AnswerQuestionDetail extends StatefulWidget {
  final AnswerQuestionModel answerQuestionModel;

  const AnswerQuestionDetail({
    super.key,
    required this.answerQuestionModel,
  });

  @override
  State<AnswerQuestionDetail> createState() => _AnswerQuestionDetailState();
}

class _AnswerQuestionDetailState extends State<AnswerQuestionDetail> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    if (widget.answerQuestionModel.questionAndAnswer.isEmpty) {
      return const Scaffold(
        appBar: CustomAppBar(),
        body: Center(
          child: CommonNoDataWidget(),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.callCenterQuestionAnswered.tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(
            widget.answerQuestionModel.questionAndAnswer.length,
            (index) {
              final value = widget.answerQuestionModel.questionAndAnswer[index];

              return CommonExpandableListWidget(
                title: value.question,
                index: index,
                body: HtmlWidget(
                  value.answer,
                  textStyle: textTheme.bodyLarge!.copyWith(fontSize: 14),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}


//dfdfdfdef