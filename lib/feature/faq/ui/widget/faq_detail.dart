import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/feature/faq/model/faq_model.dart';

import '../../../../common/app/theme.dart';
import '../../../../common/widget/app_bar/custom_app_bar.dart';

class FaqDetailsWidget extends StatelessWidget {
  final FAQModel faqModel;

  const FaqDetailsWidget({
    super.key,
    required this.faqModel,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.faq.tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CustomTheme.symmetricHozPadding.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 24.hp,
                  ),
                  Text(
                    faqModel.title,
                    style: textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 24.hp,
                  ),
                  Text(
                    faqModel.description,
                    style: textTheme.headlineSmall!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
