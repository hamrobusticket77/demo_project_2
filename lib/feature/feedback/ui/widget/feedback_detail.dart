import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/feature/auth/constant/feedback_status.dart';
import 'package:krishi_hub/feature/feedback/model/feedback_list_model.dart';

class FeedbackDetailsWidget extends StatefulWidget {
  final FeedbackListModel feedbackModel;

  const FeedbackDetailsWidget({
    required this.feedbackModel,
    super.key,
  });

  @override
  State<FeedbackDetailsWidget> createState() => _FeedbackDetailsWidgetState();
}

String feedbackStatus = "";

class _FeedbackDetailsWidgetState extends State<FeedbackDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.feedback.tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding.wp),
          child: Column(
            children: <Widget>[
              SizedBox(height: 15.hp),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: CustomTheme.symmetricHozPadding.wp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.feedbackModel.title.toString().capitalize(),
                      style: textTheme.displaySmall!,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.hp),
              Container(
                // margin: EdgeInsets.symmetric(
                padding: EdgeInsets.all(20.wp),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(-3, 3),
                      spreadRadius: 5,
                      blurRadius: 2,
                      color: CustomTheme.lightGray.withOpacity(0.5),
                    ),
                    BoxShadow(
                      offset: const Offset(3, -3),
                      spreadRadius: 5,
                      blurRadius: 3,
                      color: CustomTheme.lightGray.withOpacity(0.5),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: CustomTheme.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          LocaleKeys.feedback.tr(),
                          textAlign: TextAlign.start,
                          style: textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context).colorScheme.tertiary),
                        ),
                        SizedBox(
                          width: 10.hp,
                        ),
                        Container(
                          height: 15.wp,
                          width: 15.wp,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: FeedbackStatus.getFeedbackStatusColor(
                                feedbackStatus),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.hp),
                    Row(
                      children: [
                        Text(
                          "${LocaleKeys.status.tr()}:",
                          style: textTheme.bodyLarge!
                              .copyWith(color: CustomTheme.grey),
                        ),
                        SizedBox(
                          width: 10.wp,
                        ),
                        Text(
                          CheckLocal.check(FeedbackStatus.getFeedbackStatus(
                                  feedbackStatus))
                              .capitalize(),
                          style: textTheme.bodyLarge!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.hp),
                    Text(
                      widget.feedbackModel.description ?? "",
                      style: textTheme.bodyLarge!
                          .copyWith(color: CustomTheme.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
