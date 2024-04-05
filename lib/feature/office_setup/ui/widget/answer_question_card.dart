import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/common/widget/date_formater_utils.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/feature/auth/utils/fullname_utils.dart';
import 'package:krishi_hub/feature/office_setup/model/answer_question_model.dart';

class AnswerQuestionCard extends StatelessWidget {
  final Function()? onPressed;

  final EdgeInsetsGeometry? margin;

  final AnswerQuestionModel answerquestionModel;

  const AnswerQuestionCard({
    super.key,
    required this.answerquestionModel,
    required this.onPressed,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CommonCardWrapper(
      onTap: onPressed,
      margin: margin ??
          EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding.wp, vertical: 10.hp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextTileWidget(
            title: LocaleKeys.date.tr(),
            subTitle: DateFormatterUtils.convertAdIntoBsString(
                answerquestionModel.createdAt ?? ""),
          ),
          TextTileWidget(
            title: LocaleKeys.fullname.tr(),
            subTitle: FullNameUtils.getFullNameOnly(
              firstName: answerquestionModel.callerFirstName,
              lastName: answerquestionModel.callerLastName,
              middleName: answerquestionModel.callerMiddleName,
            ),
          ),
          TextTileWidget(
            title: LocaleKeys.email.tr(),
            subTitle: answerquestionModel.callerEmail,
          ),
          TextTileWidget(
            title: LocaleKeys.phoneNumber.tr(),
            subTitle: answerquestionModel.callerPhoneNumber.toNepali(),
          ),
        ],
      ),
    );
  }
}
