import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/dismissable_wrapper_widget.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';

import 'package:krishi_hub/feature/feedback/cubit/delete_feedback_cubit.dart';
import 'package:krishi_hub/feature/feedback/model/feedback_list_model.dart';
import 'package:krishi_hub/feature/feedback/ui/widget/feedback_delete_dialog.dart';

class FeedbackCard extends StatelessWidget {
  final Function()? onPressed;
  final EdgeInsetsGeometry? margin;
  final FeedbackListModel feedbacklistModel;

  const FeedbackCard({
    super.key,
    required this.feedbacklistModel,
    required this.onPressed,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    return DismissableWrapper(
      dismissDirection: DismissDirection.endToStart,
      onConfirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return await deleteFeedbackDialog(
              context: context,
              onPressed: () {
                context
                    .read<DeleteFeedback>()
                    .deleteAgriculturePlan(id: feedbacklistModel.id);
              }).then((value) {
            if (value != null && value) {
              return true;
            } else {
              return false;
            }
          });
        } else {
          return false;
        }
      },
      id: feedbacklistModel.id,
      margin: margin ??
          EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding.wp, vertical: 10.hp),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          // context.read<GetNewsCubit>().getNews();
        }
      },
      child: CommonCardWrapper(
        onTap: onPressed,
        margin: margin ??
            EdgeInsets.symmetric(
                horizontal: CustomTheme.symmetricHozPadding.wp,
                vertical: 10.hp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextTileWidget(
              title: LocaleKeys.fullname.tr(),
              subTitle: feedbacklistModel.name.toString(),
            ),
            TextTileWidget(
              title: LocaleKeys.title.tr(),
              subTitle: feedbacklistModel.title.toString(),
            ),
            TextTileWidget(
              title: LocaleKeys.phoneNumber.tr(),
              subTitle: feedbacklistModel.phoneNumber.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
