import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';

import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/button/custom_outline_button.dart';
import 'package:krishi_hub/common/widget/button/custom_view_button.dart';
import 'package:krishi_hub/common/widget/date_formater_utils.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/feature/phone_book/model/office_model.dart';
import 'package:krishi_hub/feature/phone_book/model/sub_office_model.dart';

class SubOfficeCard extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final SubofficeModel subofficeModel;
  final Function() onPressed;
  const SubOfficeCard({
    Key? key,
    required this.subofficeModel,
    required this.onPressed,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: CustomTheme.symmetricHozPadding.wp, vertical: 5.hp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CommonCardWrapper(
            margin:
                margin ?? EdgeInsets.symmetric(horizontal: 0, vertical: 5.hp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextTileWidget(
                  title: LocaleKeys.date.tr(),
                  subTitle: DateFormatterUtils.convertAdIntoBs(
                      subofficeModel.createdAt),
                ),
                TextTileWidget(
                  title: LocaleKeys.office.tr(),
                  subTitle: subofficeModel.title,
                ),
                // TextTileWidget(
                //   title: "Department",
                //   subTitle: subofficeModel,
                // ),
                CustomViewIcons(
                  onpress: onPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
